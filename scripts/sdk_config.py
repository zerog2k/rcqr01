from pathlib import Path
import os


DEFAULT_SDK_PATH = "../nRF5_SDK_12.3.0_d7731ad"


def _load_dotenv(project_root):
    env_file = project_root / ".env"
    if not env_file.is_file():
        return

    for line in env_file.read_text().splitlines():
        line = line.strip()
        if not line or line.startswith("#") or "=" not in line:
            continue
        key, _, value = line.partition("=")
        os.environ.setdefault(key.strip(), value.strip().strip("\"'"))


def resolve_sdk_path(project_root, override=None):
    _load_dotenv(project_root)
    configured = override or os.environ.get("NRF_SDK_DIR", DEFAULT_SDK_PATH)
    sdk_path = Path(configured).expanduser()
    if not sdk_path.is_absolute():
        sdk_path = project_root / sdk_path
    return sdk_path.resolve()


def validate_sdk_path(sdk_path):
    required = (
        "components/device/nrf51.h",
        "components/libraries/timer/app_timer.c",
        "components/proprietary_rf/esb/nrf_esb.h",
        "components/proprietary_rf/esb/nrf_esb.c",
        "components/softdevice/s130/toolchain/armgcc/"
        "armgcc_s130_nrf51822_xxaa.ld",
        "external/segger_rtt/SEGGER_RTT.c",
        "external/segger_rtt/SEGGER_RTT_Conf.h",
    )
    missing = [path for path in required if not (sdk_path / path).is_file()]
    if missing:
        details = "\n".join(f"  - {path}" for path in missing)
        raise RuntimeError(f"SDK is missing required files:\n{details}")
