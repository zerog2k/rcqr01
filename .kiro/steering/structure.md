# Project Structure

```
rcqr01/
├── src/                    # Application source code
│   ├── main.c              # Entry point, main loop, top-level init
│   ├── apptimers.h         # App timer init, 1ms/1s ticks, backlight PWM
│   ├── keypad.h            # 8x8 matrix keypad scan and key lookup table
│   ├── radio.h             # Nordic ESB radio init and TX
│   ├── sleep.h             # Sleep mode state machine and constants
│   ├── adc_hal.h           # ADC / battery voltage reading
│   ├── display.c/.h        # u8g2 display initialization and contrast control
│   ├── u8g2_nrf51.c/.h     # nRF51 SPI and GPIO callbacks for u8g2
│   ├── u8x8_d_st7586_rcqr01.c/.h # Custom 360x160 ST7586 driver
│   ├── board_ST7586.h      # Board-level pin/config for ST7586 LCD driver
│   ├── sdk_includes.c      # Selected nRF5 SDK source compilation unit
│   └── sdk_config.h        # Nordic SDK peripheral/module enable flags
├── eeprom.h                # CAT25512 SPI EEPROM driver (at root, not src/)
├── lib/nrf5_sdk/           # Selected SDK source subset used by sdk_includes.c
├── boards/
│   └── rcqr01.json         # PlatformIO board definition
├── docs/                   # Hardware photos and reference images
└── scripts/                # PlatformIO environment and RTT/debug helpers
```

## Conventions

- **Modules are mostly header-only** — peripheral drivers and subsystems live in `.h` files and are `#include`d directly into `main.c`. Separate `.c` files provide display glue, the custom display driver, and selected SDK sources.
- **`eeprom.h` lives at the root**, not in `src/` — keep it there for consistency.
- **Static functions** are used for internal/helper functions within header modules (e.g., `static void _write_byte(...)`).
- **Pin numbers are `#define`d as bare integers** matching the nRF51822 GPIO port numbers from the pinout table.
- **`APP_ERROR_CHECK`** wraps all SDK calls that return `ret_code_t` — always check errors this way.
- **`NRF_LOG_*` macros** are used for all debug output (`NRF_LOG_DEBUG`, `NRF_LOG_INFO`, `NRF_LOG_WARNING`). Printf-style format strings use `\n` or `\r\n`.
- **RAM is severely limited (16 KB)** — avoid heap allocation, large stack variables, or buffers. The 1bpp framebuffer is already a significant RAM consumer.
- **u8g2 page mode** is used for display rendering. Use `u8g2_FirstPage()` / `u8g2_NextPage()` and keep the page buffer small because RAM is limited.
- **`__WFE` / `__SEV`** idiom is used for low-power waiting in the main loop — do not use busy-wait delays in the main loop body.
