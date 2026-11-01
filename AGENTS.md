# AGENTS.md

Agent guidance for the RCQR-01 firmware repo (reverse-engineered Turning
Technologies "clicker", nRF51822, PlatformIO, bare-metal C).

## Read this first

Before making changes, read these for context. They are the source of truth;
this file only summarizes and points at them.

1. `README.md` — hardware overview, pinout, build/programming workflow,
   SDK patching, TODOs.
2. `docs/` — reference material, hardware photos, and design/verification
   plans in `docs/plans/` (read the relevant plan before touching the area it
   covers).
3. `.kiro/steering/*.md` — durable project conventions:
   - `product.md` — what the firmware does and its hardware summary
   - `structure.md` — file layout and coding conventions
   - `tech.md` — toolchain, SDK, libraries, common commands

If those disagree with the code, trust the code and note the discrepancy
rather than silently following a stale doc.

## Project shape

- Target environment: `nrf51_rcqr01_standalone`
- `src/` — application and drivers; mostly header-only modules `#include`d
  into `src/main.c`, plus a few `.c` files (display glue, custom u8x8 ST7586
  driver, selected SDK sources)
- `eeprom.h` intentionally lives at the repo root, not in `src/`
- `scripts/` — SDK setup and RTT/debug helpers
- External nRF5 SDK 12.3.0 checkout at `../nRF5_SDK_12.3.0_d7731ad`
  (override with `NRF_SDK_DIR` in `.env` or `--sdk`)

## Build and verify

```sh
python3 scripts/setup_sdk.py                                   # once, prepares/patch-checks the SDK
python3 -m platformio run -e nrf51_rcqr01_standalone           # build
python3 -m platformio run -e nrf51_rcqr01_standalone -t upload # flash via ST-Link
```

Build after any source change. There is no unit-test suite; hardware behavior
is verified with the display/keypad/radio/EEPROM/RTT checklist in
`docs/plans/u8g2-migration.md`.

## Hard constraints

- 16 KB RAM (nRF51822 QFAA). No heap allocation, no large stack buffers, keep
  framebuffers and page buffers small.
- Display uses u8g2 page mode (`u8g2_FirstPage()` / `u8g2_NextPage()`); the
  panel is 340x160 with the custom `u8x8_d_st7586_rcqr01` 3-pixels-per-byte
  format.
- Main loop must stay non-blocking: use `__WFE`/`__SEV` and app timers, never
  busy-wait delays.
- Wrap fallible SDK calls with `APP_ERROR_CHECK`; log with `NRF_LOG_*`.

## Editing conventions

- Match surrounding style: `static` helpers prefixed `_`, bare integer pin
  `#define`s, header-only modules.
- Do not hand-edit the external SDK checkout; changes belong in
  `scripts/setup_sdk.py` (idempotent) with `patches/` kept as documentation.
- Keep `.env` out of commits (gitignored); update `.env.example` instead.
