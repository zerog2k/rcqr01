# Technical Migration Record: uGFX → u8g2 (VS Code + PlatformIO)

**Target hardware** – Nordic nRF51822 (16 KB RAM, 256 KB Flash)

**Display** – ST7586 (360 × 160 monochrome, 1‑bpp)

**Build system** – VS Code + PlatformIO (`platform = nordicnrf51`)

**SDK baseline** – nRF5 SDK v12.3.x

---

## 1. Architectural strategy & RAM constraints

| Item | Size |
|------|------|
| Display pixels | 360 × 160 = 57 600 px |
| Full 1‑bpp framebuffer | 57 600 / 8 = 7 200 B (≈ 44 % of RAM) – **unacceptable** |
| u8g2 page buffer (16‑line) | (360 × 16) / 8 = 720 B – saves ~6 KB RAM |

The ST7586 uses an unusual three-pixels-per-byte format. The stock u8g2
constructors do not match this 360x160 panel, so the project uses a custom
u8x8 driver.

---

## 2. PlatformIO configuration (`platformio.ini`)

```ini
[env:nrf51822]
platform = nordicnrf51
board = nrf51822
framework = cmsis

; Pull in u8g2 from the PlatformIO registry
lib_deps =
    olikraus/U8g2 @ ^2.34.22

build_flags =
    -I src/
    -I src/config
    -D NRF51
    -D U8G2_WITH_CLIP_WINDOW
    -D U8G2_16BIT

; Disable aggressive size optimisations that strip needed code
build_unflags = -Os
```

---

## 3. Migration phases

### Phase 1 – Remove the legacy uGFX stack [COMPLETED]
1. Delete `src/gfx_mk.c`, `src/gdisp_lld_framebuffer.c`, `src/gfxconf.h`. **DONE**
2. Delete the entire `uGFX/` directory. **DONE**
3. Ensure `main.c` no longer includes `gfx.h`. **DONE**

### Phase 2 – Add u8g2 glue code [COMPLETED]
Create **src/u8g2_nrf51.c** and **src/u8g2_nrf51.h** containing the two callbacks required by u8g2:
* `u8x8_gpio_and_delay_nrf51()` – configures `LCD_CS`, `LCD_DC`, `LCD_RST` and implements the delay messages. **DONE**
* `u8x8_byte_nrf51_hw_spi()` – forwards byte streams to the existing `nrf_drv_spi` instance (`spi`) that is already initialised in `board_ST7586.h`. **DONE**

### Phase 3 – Display initialisation [COMPLETED]

Note: `u8g2_Setup_st7586_jlx320160_1` from the original sketch (**and any stock
u8g2 st7586s constructor**) does **not match this hardware**. The panel is
360×160 with its leftmost 21 controller columns hidden (visible data starts at
column 21/3 = 7); u8g2 2.x only ships 320×160/384×160 st7586s constructors with
no column offset. So Phase 3 was completed with a small custom u8x8 driver
instead of a stock constructor (see below for all deviations from the sketch).

Files created/changed:

* **src/display.h / src/display.c** – `display_init()` + `extern u8g2_t u8g2`.
  Validates/allocates a **360-byte 1-page buffer** (45 tiles × 8 lines — the
  plan's "720 B" figure assumed a 320-wide panel). Pins are set via
  `u8x8_SetPin(u8g2_GetU8x8(...), U8X8_PIN_CS, LCD_CS)` (the sketch's
  `u8g2_SetPin`/`U8G2_PIN_*` names don't exist in u8g2).
* **src/u8x8_d_st7586_rcqr01.c/.h** – custom u8x8 display driver ported from the
  original working uGFX ST7586 driver (same geometry, init sequence, 3-px/byte
  packing as u8g2's `st7586s` drivers).
* **src/board_ST7586.h** – rewritten from the legacy uGFX board file into a
  plain C header (LCD pin defines, `extern const nrf_drv_spi_t spi`,
  `st7586_board_init()` declaration). The `spi` instance and
  `st7586_board_init()` (pin config + hw reset + `nrf_drv_spi_init`) live in
  **src/u8g2_nrf51.c**; `u8x8_byte_nrf51_hw_spi()` now busy-waits on
  `spi_xfer_done` since `nrf_drv_spi_transfer()` is asynchronous.
* Includes: pure-C code must use `#include "clib/u8g2.h"` (the C library). Do
  **not** `#include "U8g2lib.h"` — it is a C++ wrapper (pulls in Arduino.h and a
  ~5000-line `class` definition, both rejected by the C compiler).
* `platformio.ini`: removed `-D U8G2_16BIT` (u8g2.h defines it itself; the
  redefinition warned on every compile).

**Checkpoint:** `python3 -m platformio run -e nrf51_rcqr01_standalone`
– all Phase-3 objects compile without errors/warnings. The build still fails in
`src/main.c` (vestigial `#include "st7586.h"` + remaining `gdisp*` calls) –
resolved in Phase 4.

### Phase 4 – Replace rendering code [COMPLETED]
* `src/main.c`: removed the vestigial `#include "st7586.h"`, removed the uGFX
  helper functions (`gfxSystemTicks`, `gfxMillisecondsToTicks`), and
  `display_init()` is called early in `main()` where `gfxInit()` used to be.
* Removed `font_t font_small, font_med`; fonts are now u8g2 built-ins selected
  directly in the draw functions (`u8g2_font_6x10_tf`,
  `u8g2_font_10x20_tf`).
* The boot info screen is drawn in a u8g2 page loop (`u8g2_FirstPage` /
  `u8g2_NextPage`); the old `gdispFillCircle`/`gdispDrawBox` test graphics were
  converted to commented `u8g2_DrawDisc`/`u8g2_DrawBox` equivalents.
* All the `gdispFillString` status lines in the keypress handler were replaced
  by a single `render_status()` helper that clears the buffer and redraws every
  line inside one page loop.
* `gdispGetContrast`/`gdispSetContrast` were replaced by
  `display_contrast_get()`/`display_contrast_set()` in `src/display.c`. The
  ST7586 has no contrast register, so set is implemented by stepping `VOP
  increment` (0xC1) / `VOP decrement` (0xC2) commands, exactly like the
  original uGFX control path. 0..100 usable range.
* `#include <stdio.h>` added for `sprintf`; `%d`-style formats fixed to
  `%lu`/`%u`/`%lx` (uint32_t is `unsigned long` on this toolchain) and a stray
  line-continuation backslash in a `//` comment fixed.

**Checkpoint:** `~/.platformio/penv/bin/platformio run
-e nrf51_rcqr01_standalone` – **SUCCESS**, the full project compiles and links.
Remaining warnings are pre-existing (unused helpers in `eeprom.h`,
`NRF_LOG_MODULE_NAME` redefinitions in `radio.h`, missing return in
`radio.h:send_char`).

### Phase 5 – Verify memory usage [COMPLETED]
Full build reports:
* **RAM: 2 912 B of 16 KB (17.8 %)** – far below the 11.5 KB target; the
  360-byte page buffer saves ~6.9 KB over a full framebuffer.
* **Flash: 24 684 B of 256 KB (9.4 %)**.

No further trimming of fonts or UI code required. (Phase-2 note: also compare
against the old build only if a baseline snapshot exists.)

### Phase 6 – Test & debug [PENDING HARDWARE VERIFICATION]
Flash the binary and verify on hardware. Checklist:

1. Flash: `~/.platformio/penv/bin/platformio run -e nrf51_rcqr01_standalone -t
   upload` (stlink attached to the battery-compartment pad row).
2. RTT: attach with `scripts/start-rtt.gdb` / OpenOCD RTT; expect the
   `entered main`, `startup: display drawn`, `entering main loop` traces.
3. Visual checks against the old firmware behaviour:
   - boot screen shows RF channel / IC rev / flash / RAM info lines and
     "Hello lcd"
   - text position and orientation are right-way-up (scan direction is
     `0x36 0xc8`, MY=1/MX=1, kept from the original driver; if the image is
     mirrored/rotated, bump to `U8G2_R180` or switch the scan-direction init
     in `src/u8x8_d_st7586_rcqr01.c`)
   - left/right arrow keys step the contrast (default VOP step = 51 → the
     original 0x100 VOP plus steps; if too dark/bright adjust the initial
     `display_contrast` or `VOP_CAA` values in the init sequence)
   - keypad chars redraw the status screen and radio still transmits.
4. Compare draw latency: `prev draw delay` line shows elapsed tick between
   renders (old uGFX driver logged `gdisp_lld_flush` times for reference).

---

## 4. Font selection (matching old uGFX sizes)
* **Small (7 × 14‑like)** – `u8g2_font_6x10_tf`
* **Medium (10 × 20‑like)** – `u8g2_font_10x20_tf`
These fonts are built‑in, require no extra memory, and closely resemble the previous `fixed_7x14` and `fixed_10x20` fonts.

---

## 5. Cleanup & documentation [COMPLETED]

The legacy SEGGER Embedded Studio project/session files, uGFX-specific source
files, framebuffer configuration, custom startup file, and Travis scaffold have
been removed. The repository documentation now describes the PlatformIO/u8g2
workflow.

The full SDK checkout remains external at
`../nRF5_SDK_12.3.0_d7731ad/`. `scripts/setup_sdk.py` prepares and validates
the checkout, while `scripts/configure_sdk.py` supplies the same SDK root to
PlatformIO for headers, source files, RTT, and the linker script. No SDK source
mirror is kept in this repository.
