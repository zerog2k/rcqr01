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
│   ├── rtc.h               # RTC experimentation (unused, replaced by app_timer)
│   ├── board_ST7586.h      # Board-level pin/config for ST7586 LCD driver
│   ├── board_framebuffer.h # Framebuffer board config for uGFX
│   ├── gdisp_lld_framebuffer.c # uGFX low-level framebuffer driver
│   ├── gfx_mk.c            # uGFX module aggregation compile unit
│   ├── gfxconf.h           # uGFX feature configuration
│   └── sdk_config.h        # Nordic SDK peripheral/module enable flags
├── eeprom.h                # CAT25512 SPI EEPROM driver (at root, not src/)
├── uGFX/                   # uGFX submodule (display/UI framework)
│   └── drivers/gdisp/ST7586/ # ST7586 LCD driver for uGFX
├── lib/uGFX/               # PlatformIO lib symlink/stub (not actively used)
├── boards/
│   └── rcqr01.json         # PlatformIO board definition
├── docs/                   # Hardware photos and reference images
├── rcqr01_demo1.emProject  # SEGGER Embedded Studio project file
├── rcqr01_demo1.emSession  # SEGGER Embedded Studio session state
├── flash_placement.xml     # Linker memory segment placement
├── thumb_crt0.s            # Custom Thumb C runtime startup
└── .travis.yml             # CI config (scaffolded, not active)
```

## Conventions

- **Modules are mostly header-only** — peripheral drivers and subsystems live in `.h` files and are `#include`d directly into `main.c`. There are no separate `.c` files per module (except uGFX glue and SDK sources).
- **`eeprom.h` lives at the root**, not in `src/` — keep it there for consistency.
- **Static functions** are used for internal/helper functions within header modules (e.g., `static void _write_byte(...)`).
- **Pin numbers are `#define`d as bare integers** matching the nRF51822 GPIO port numbers from the pinout table.
- **`APP_ERROR_CHECK`** wraps all SDK calls that return `ret_code_t` — always check errors this way.
- **`NRF_LOG_*` macros** are used for all debug output (`NRF_LOG_DEBUG`, `NRF_LOG_INFO`, `NRF_LOG_WARNING`). Printf-style format strings use `\n` or `\r\n`.
- **RAM is severely limited (16 KB)** — avoid heap allocation, large stack variables, or buffers. The 1bpp framebuffer is already a significant RAM consumer.
- **uGFX API** is used for all display operations: `gdispDrawString`, `gdispFillString`, `gdispFlush`, `gdispSetContrast`, etc. Always call `gdispFlush()` after drawing to push the framebuffer to the LCD.
- **`__WFE` / `__SEV`** idiom is used for low-power waiting in the main loop — do not use busy-wait delays in the main loop body.
