from pathlib import Path
import sys

Import("env")

project_root = Path(env.subst("$PROJECT_DIR")).resolve()
sys.path.insert(0, str(project_root / "scripts"))

from sdk_config import resolve_sdk_path, validate_sdk_path


sdk_path = resolve_sdk_path(project_root)
try:
    validate_sdk_path(sdk_path)
except RuntimeError as error:
    raise RuntimeError(
        f"{error}\nRun `python3 scripts/setup_sdk.py` after downloading the SDK, "
        "or set NRF_SDK_DIR to the SDK checkout."
    )

component_dirs = [
    "components/drivers_nrf/hal",
    "components/drivers_nrf/delay",
    "components/drivers_nrf/clock",
    "components/drivers_nrf/common",
    "components/drivers_nrf/spi_master",
    "components/drivers_nrf/rtc",
    "components/libraries/timer",
    "components/libraries/ic_info",
    "components/libraries/log",
    "components/libraries/log/src",
    "components/libraries/low_power_pwm",
    "components/libraries/util",
    "components/proprietary_rf/esb",
    "components/softdevice/s130/headers",
    "external/segger_rtt",
]
env.Append(CPPPATH=[str(sdk_path / path) for path in component_dirs])
env.Append(CPPDEFINES=[("NRF_SDK_DIR", f'"{sdk_path.as_posix()}"')])

if env.get("PIOENV") != "nrf51_rcqr01_standalone":
    env.Replace(
        LDSCRIPT_PATH=str(
            sdk_path
            / "components/softdevice/s130/toolchain/armgcc/"
            "armgcc_s130_nrf51822_xxaa.ld"
        )
    )
