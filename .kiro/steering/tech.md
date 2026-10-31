# Tech Stack

## Language & Standard
- C (gnu11), with some C++ headers (`.h` files using C++ style includes)
- ARM Cortex-M0 (ARMv6-M), little-endian, soft-float ABI

## IDE & Build System
- **SEGGER Embedded Studio** (`.emProject` project file) — primary IDE and build tool
- **PlatformIO** — CI/Travis integration scaffolded but not actively used
- Build output goes to `_build/` directory
- Two build configurations: `debug` (optimization off, RTT enabled) and `release` (O2, RTT/logging disabled)

## SDK & Dependencies
- **Nordic nRF5 SDK 12.3.0** — referenced via `NRF_SDK_DIR` project macro (default: `../../nRF5_SDK_12.3.0`)
  - Required SDK patches:
    1. `nrf_esb.h`: rename `nrf_esb_rf_channel_get` → `nrf_esb_get_rf_channel`
    2. `app_timer.c`: change `SWI_IRQn`/`SWI_IRQHandler` to use `SWI3` instead of `SWI0`
- **uGFX** — display/UI framework, included as a git submodule (`uGFX/`), forked at `zerog2k/uGFX`
- **SEGGER RTT** — used for debug logging (via `NRF_LOG` macros backed by RTT in debug builds)

## Key Libraries Used (from SDK)
- `nrf_drv_spi` — SPI master driver (used for LCD and EEPROM)
- `nrf_esb` — Enhanced ShockBurst proprietary RF
- `app_timer` — software timers over RTC1 (1 ms tick, 1 s tick)
- `low_power_pwm` — backlight PWM via app_timer
- `nrf_drv_clock` — LFCLK management
- `nrf_log` / `SEGGER_RTT` — logging

## Preprocessor Defines
- `NRF51822`, `NRF51`, `SWI_DISABLE0` (common)
- Release adds: `NRF_LOG_DEFAULT_LEVEL=0`, `NRF_LOG_BACKEND_SERIAL_USES_RTT=0`

## Programming & Debugging
- **SEGGER J-Link** via SWD (SWDIO/SWDCLK exposed on battery compartment test pads)
- RTT viewer for log output in debug builds
- Flash target: `nRF51822_xxAA` (256 KB flash, 16 KB RAM)

## Common Commands
All build/flash operations are done inside Segger Embedded Studio — there is no standalone CLI build system in use. Use the IDE's Build, Clean, and Download commands.

For PlatformIO (if adopted):
```sh
platformio run              # build
platformio run --target upload  # flash
```
