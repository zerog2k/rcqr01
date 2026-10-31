# Tech Stack

## Language & Standard
- C (gnu11), with some C++ headers (`.h` files using C++ style includes)
- ARM Cortex-M0 (ARMv6-M), little-endian, soft-float ABI

## IDE & Build System
- **VS Code + PlatformIO** — current build and debug workflow
- Build environment: `nrf51_rcqr01_standalone`
- Build output goes to `.pio/build/`
- SEGGER Embedded Studio project/session files and Travis configuration are obsolete and removed

## SDK & Dependencies
- **Nordic nRF5 SDK 12.3.0** — external checkout at `../nRF5_SDK_12.3.0_d7731ad`
  - Provides headers, linker files, RTT, and the SDK tree used by the build
  - Selected SDK source files are currently mirrored under `lib/nrf5_sdk/` and compiled by `src/sdk_includes.c`
  - The external checkout contains the ESB getter and app-timer SWI3 compatibility fixes
- **u8g2** — display rendering library from PlatformIO
- **Custom u8x8 ST7586 driver** — project-specific 360x160 LCD transport and packing
- **SEGGER RTT** — used for debug logging (via `NRF_LOG` macros backed by RTT in debug builds)

## Key Libraries Used (from SDK)
- `nrf_drv_spi` — SPI master driver (used for LCD and EEPROM)
- `nrf_esb` — Enhanced ShockBurst proprietary RF
- `app_timer` — software timers over RTC1 (1 ms tick, 1 s tick)
- `low_power_pwm` — backlight PWM via app_timer
- `nrf_drv_clock` — LFCLK management
- `nrf_log` / `SEGGER_RTT` — logging

## Preprocessor Defines
- `NRF51822`, `NRF51`
- `U8G2_WITH_CLIP_WINDOW`

## Programming & Debugging
- **ST-Link** via SWD (SWDIO/SWDCLK exposed on battery compartment test pads)
- SEGGER RTT/OpenOCD for log output during debugging
- Flash target: `nRF51822_xxAA` (256 KB flash, 16 KB RAM)

## Common Commands
```sh
python3 -m platformio run -e nrf51_rcqr01_standalone
python3 -m platformio run -e nrf51_rcqr01_standalone -t upload
```
