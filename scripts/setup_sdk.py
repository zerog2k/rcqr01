#!/usr/bin/env python3

import argparse
from pathlib import Path

from sdk_config import resolve_sdk_path, validate_sdk_path


def apply_replacement(path, old, new, description, check_only):
    content = path.read_text()
    if new in content and old not in content:
        return False
    if old not in content:
        raise RuntimeError(
            f"Could not locate the expected unpatched text for {description} in {path}"
        )
    if content.count(old) != 1:
        raise RuntimeError(f"Expected one occurrence for {description} in {path}")
    if check_only:
        raise RuntimeError(f"SDK patch is missing: {description} ({path})")
    path.write_text(content.replace(old, new))
    return True


def main():
    parser = argparse.ArgumentParser(description="Prepare the external nRF5 SDK")
    parser.add_argument("--sdk", help="Path to the nRF5 SDK checkout")
    parser.add_argument(
        "--check",
        action="store_true",
        help="Only verify the SDK and required compatibility fixes",
    )
    args = parser.parse_args()

    project_root = Path(__file__).resolve().parent.parent
    sdk_path = resolve_sdk_path(project_root, args.sdk)
    validate_sdk_path(sdk_path)

    changed = []
    if apply_replacement(
        sdk_path / "components/proprietary_rf/esb/nrf_esb.h",
        "nrf_esb_rf_channel_get",
        "nrf_esb_get_rf_channel",
        "ESB channel getter",
        args.check,
    ):
        changed.append("ESB channel getter")
    if apply_replacement(
        sdk_path / "components/libraries/timer/app_timer.c",
        "#define SWI_IRQn SWI0_IRQn",
        "#define SWI_IRQn SWI3_IRQn",
        "app timer IRQ",
        args.check,
    ):
        changed.append("app timer IRQ")
    apply_replacement(
        sdk_path / "components/libraries/timer/app_timer.c",
        "#define SWI_IRQHandler SWI0_IRQHandler",
        "#define SWI_IRQHandler SWI3_IRQHandler",
        "app timer handler",
        args.check,
    )
    if apply_replacement(
        sdk_path / "components/proprietary_rf/esb/nrf_esb.c",
        "    uint32_t inp = (*(uint32_t*)p_inp);",
        "    /* m_esb_addr has byte alignment, so this load may be unaligned;\n"
        "       Cortex-M0 faults on unaligned word accesses. Read bytewise. */\n"
        "    uint32_t inp = ((uint32_t)p_inp[0])       |\n"
        "                   ((uint32_t)p_inp[1] << 8)  |\n"
        "                   ((uint32_t)p_inp[2] << 16) |\n"
        "                   ((uint32_t)p_inp[3] << 24);",
        "ESB unaligned address load",
        args.check,
    ):
        changed.append("ESB unaligned address load")

    if changed:
        print(f"Patched SDK at {sdk_path}: {', '.join(changed)}")
    else:
        print(f"SDK is ready at {sdk_path}")


if __name__ == "__main__":
    try:
        main()
    except RuntimeError as error:
        raise SystemExit(f"error: {error}")
