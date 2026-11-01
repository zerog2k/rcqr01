# Render Latency Plan: Coalesced SPI, Blank-Page Skip, Transparent Fonts

**Target hardware** – Nordic nRF51822 (Cortex-M0, 16 MHz, 16 KB RAM)
**Display** – ST7586 340×160, 2-bit grey data packed 3 pixels/byte
**Build** – PlatformIO, `nrf51_rcqr01_standalone`
**Status** – B1, B2, C1 and D implemented; latency measurement and the final
hardware checklist are still outstanding.

| Phase | Change | Commit | Measurement |
|-------|--------|--------|-------------|
| B1 | Blocking LCD SPI | `7ca136c` | not measured |
| B2 | 255-byte coalesced transfers | `58d4c51` | not measured |
| C1 | Blank-page skip | `7a31173` | not measured |
| D | Transparent font mode | `edc2da2` | not measured |
| C2 | Page cache | deferred | — |

The plan is **not complete**: none of the acceptance criteria can be signed
off until the measurement table in §3 is filled in with a release build and
the checklist in §10 is run on hardware. See §13 for implementation details,
deviations and the current verification state.

---

## 1. Goal and acceptance criteria

Bring `render_status()` (the number shown in the on-screen `delay:` field) down
from the estimated **~500–600 ms** to **≤ 200 ms** (median, normal release
build). Stretch target: **≤ 120 ms**.

Acceptance criteria for the whole plan:

- Median draw time ≤ 200 ms with the release build.
- The status screen, boot screen, contrast arrows, sleep/wake and EEPROM scan
  all look and behave exactly as before.
- No ghost/stale text after waking from display sleep, after the `s` key
  power-cycles the LCD regulator, or after a reset.
- RAM increase is accounted for; no heap allocation.

Priority is latency only. Do not change the on-screen layout or the font as
part of this plan.

---

## 2. Baseline before phases B–D (why it was slow)

This section describes the **pre-change** redraw path (Phase 0). It is kept as
the reference point for the table in §3; the current code no longer matches it.
Offline analysis (same u8g2 sources, same custom driver and the same 20-page
loop, with a stubbed byte callback) gives:

| Quantity | Value |
|----------|-------|
| Pages per redraw | 20 (8 rows each) |
| Data bytes per page | 960 |
| Command/argument bytes per page | 11 |
| **Total bytes sent** | **19,420** |
| SPI wire time at 8 MHz | **~19.4 ms** |
| `nrf_drv_spi_transfer()` calls | **2,620** (2,400 × 8 B + 220 × 1 B) |
| SPI interrupts | **~19,420** (one READY IRQ per byte; nRF51 has no EasyDMA) |
| Blank pages in status screen | **8 of 20** (7,768 bytes) |
| `u8g2_DrawHVLine()` calls, solid font mode | 6,494 (3,011 fg + 3,483 bg) |
| `u8g2_DrawHVLine()` calls, transparent mode | 3,011 (fg only) |

Relevant code before the phases:

- `src/main.c:76-87` – `render_status()` page loop, `u8g2_SetFontMode(0)`
- `src/display.c:10,24-30` – 360-byte, one-tile-row page buffer
- `src/u8x8_d_st7586_rcqr01.c:137-182` – `DRAW_TILE`, one `SendData` per 3 input bytes
- `src/u8g2_nrf51.c:42,73-79` – SPI init with event handler, busy-wait per transfer
- `src/u8g2_nrf51.c` / SDK `nrf_drv_spi.c` – one `READY` interrupt per byte

The old uGFX firmware's displayed `prev draw delay` timed **only
`gdispFlush()`**; its `gdispFillString()` calls happened before the timer
started. The current code times the whole of `render_status()` (formatting +
drawing + SPI). Keep that difference in mind when comparing with historic
numbers.

When this plan was written the last artifact in `.pio/build/` was a **debug
build** (`-Og -g2`, `__PLATFORMIO_BUILD_DEBUG__`); a normal `pio run` builds
with the platform's release flag (`-Os`). That distinction is still required
for every row of the table.

Two release-build findings since then:

- Phase 0 was never measured on hardware, so the ~500–600 ms figure remains an
  offline estimate, not a baseline. The table therefore has no reference row.
- The release build used to hard-fault in `radio_init()` because of an
  unaligned ESB address load (`m_esb_addr` landed at an odd address at `-Os`;
  the debug link happened to align it). That is unrelated to display latency
  but blocked any release-build measurement. Fixed in commit `3e9964e`; see
  §13. Any release measurement taken before that fix is invalid.

---

## 3. Measurement protocol (Phase 0)

All phase comparisons must use the **same build type**. Use the release build
for headline numbers; optionally record the debug build separately.

1. Build and flash: `python3 -m platformio run -e nrf51_rcqr01_standalone -t upload`
2. Keep the device awake (the backlight/display sleeps after ~8 s).
3. Press the same key (e.g. `a`) 10 times, roughly 1 s apart.
4. Record the on-screen `delay:` value. Note: it shows the **previous**
   render's duration, so discard the first press after reset (it shows 0 or a
   stale value) and record presses 2–10.
5. Record median, min and max. The tick resolution is ~1 ms, which is fine
   below 200 ms.
6. Do not measure with a debugger halted or with heavy RTT traffic.
7. Optional higher-resolution check: toggle a spare GPIO around
   `render_status()` and measure with a scope/logic analyser, or add a
   µs-resolution timer. Not required unless the numbers get noisy.

Record results in this table when the measurements are taken (the phases have
already landed, but no numbers have been recorded):

| Phase | Build | Date | Median (ms) | Min | Max | Notes |
|-------|-------|------|-------------|-----|-----|-------|
| 0 – baseline | release | — | — | — | — | not measured; offline estimate only |
| 0 – baseline | debug | — | — | — | — | not measured; for reference |
| B1 – blocking SPI | release | 2026-10-31 | — | — | — | implemented `7ca136c`; not measured |
| B2 – coalesced 255 B | release | 2026-10-31 | — | — | — | implemented `58d4c51`; not measured |
| C1 – blank-page skip | release | 2026-10-31 | — | — | — | implemented `7a31173`; not measured |
| D – transparent font | release | 2026-10-31 | — | — | — | implemented `edc2da2`; not measured |
| C2 – page cache | — | — | — | — | — | deferred (§5) |

**Phase 0 exit gate:** not satisfied. The phases were implemented without a
recorded hardware baseline, so the numbers in this table are still the only
way to know whether the ≤ 200 ms acceptance criterion is met.

---

## 4. Phase B – SPI transport: coalescing + blocking mode

This is the largest structural change and should produce the largest single
drop. It is split into two independently measurable steps.

### B1 – Switch the LCD SPI instance to blocking mode

**Status:** implemented in `7ca136c`.

**File:** `src/u8g2_nrf51.c`

```c
/* st7586_board_init() */
APP_ERROR_CHECK(nrf_drv_spi_init(&spi, &spi_config, NULL));  /* was spi_event_handler */

/* u8x8_byte_nrf51_hw_spi(), U8X8_MSG_BYTE_SEND */
case U8X8_MSG_BYTE_SEND:
    (void)nrf_drv_spi_transfer(&spi, (uint8_t *)arg_ptr, arg_int, NULL, 0);
    break;
```

Remove `spi_event_handler()` and `spi_xfer_done` for the LCD instance (or
leave the handler function unused, but it must not be passed to
`nrf_drv_spi_init`). Keep the EEPROM SPI instance (SPI1, `eeprom.h`) exactly as
it is — it has its own handler and flag.

**Why it helps:** with a NULL handler, `nrf_drv_spi.c` polls
`EVENTS_READY`/`transfer_byte()` in a tight loop instead of taking ~19,400
interrupts per redraw. Interrupts remain enabled, so app_timer/RTC keep time.

**Risk notes:**

- Blocking SPI is a deliberate, bounded busy-wait. This conflicts in spirit
  with the "main loop must stay non-blocking" guideline in `AGENTS.md`, but
  the pre-change code already busy-waited per transfer and blocked for
  ~500 ms per redraw. This change makes the block much shorter, not longer.
  Note the trade-off in the commit message.
- `nrf_drv_spi_transfer()` returns `NRF_ERROR_BUSY` if a transfer is already
  in progress. It cannot happen in this single-threaded path; check the return
  value at least while bringing the change up.
- The EEPROM uses a different SPI instance; no shared flag.

**Expected effect:** removes ~19,400 interrupt entries/exits per redraw;
rough estimate 25–40 % off the total (the per-byte `transfer_byte()` polling
loop remains).

**Measure and gate:** record the table row. Display, contrast, sleep/wake and
EEPROM scan must all still work before B2.

### B2 – Coalesce data into ≤255-byte transfers

**Status:** implemented in `58d4c51`.

**File:** `src/u8x8_d_st7586_rcqr01.c`

The u8g2 buffer for one page is 360 bytes; it expands to exactly 960 controller
bytes. Convert the whole page into a staging buffer, then send it in
`u8x8_cad_SendData()` chunks (the CAD API count is `uint8_t`, and
`nrf_drv_spi_transfer()` length is `uint8_t`, so 255 is the maximum).

```c
/* one static staging buffer, +960 B RAM */
static uint8_t page_out[ST7586_RCQR01_DISPLAY_COLS * 8];   /* 120 * 8 = 960 */

...
uint8_t *out = page_out;
c = ((u8x8_tile_t *)arg_ptr)->cnt * 8;   /* 360 input bytes */
while (c > 0)
{
    /* existing 3-input-bytes -> 8-output-bytes expansion, writing *out++ */
}

for (uint16_t off = 0; off < sizeof(page_out); off += 255)
{
    uint8_t n = (sizeof(page_out) - off > 255) ? 255
                                               : (uint8_t)(sizeof(page_out) - off);
    u8x8_cad_SendData(u8x8, n, page_out + off);
}
```

Notes:

- Keep `u8x8_cad_StartTransfer()`/`EndTransfer()` per page so CS stays
  asserted for the whole page.
- `u8x8_cad_011`'s `SEND_DATA` already sets DC and forwards the full count in
  one byte-callback call; no CAD changes are needed.
- RAM: 960 bytes. Current static RAM is 2,912 B (`data` 556 + `bss` 2,356), so
  there is plenty of headroom.
- Optional sub-step: coalesce the 11 command/argument bytes per page into one
  transfer (they are all DC=0). That takes the total from ~300 to ~100
  transfers per redraw, but saves only a few ms; leave it out unless it is
  trivial with the chosen staging approach.
- A 255-byte rolling buffer would use less RAM, but 960 B is simpler and
  reuses the existing conversion loop almost unchanged.

**Expected effect:** 2,620 → ~300 transfers (2,400 data calls → 80), plus no
per-transfer interrupt wait. B1 + B2 together are the main fix.

**Measure and gate:** record the table row. Verify the page is not shifted or
truncated (watch the last 195-byte chunk), and that contrast commands still
work (`display_contrast_set()` uses `u8x8_cad_SendCmd`).

**Rollback:** revert the two files. No persistent state or API changes.

---

## 5. Phase C – Blank-page skip (and optional page cache)

### C1 – Skip pages that are blank and were already blank

**Status:** implemented in `7a31173`.

**File:** `src/u8x8_d_st7586_rcqr01.c` (small helper exported via
`src/display.h` for invalidation)

Every `DRAW_TILE` call receives a 360-byte, 1-bpp tile row (8 image rows). If
every byte is zero, the page contains no pixels. Keep a 20-bit map of pages
that are currently known to be blank on the panel:

```c
static uint8_t blank_pages[(20 + 7) / 8];   /* 3 bytes, 0 = "not known blank" */

void display_invalidate_panel_state(void)    /* call on init and after panel power loss */
{
    memset(blank_pages, 0, sizeof(blank_pages));
}

/* in U8X8_MSG_DISPLAY_DRAW_TILE, before StartTransfer: */
blank = tile_row_is_all_zero(tile->tile_ptr, tile->cnt * 8);
if (blank && bit_is_set(blank_pages, tile->y_pos))
    break;                                  /* panel already blank here */
if (blank) bit_set(blank_pages, tile->y_pos);
else       bit_clear(blank_pages, tile->y_pos);
```

Measured effect for the status screen: **8 of 20 pages (40 %, 7,768 bytes)**
are blank, so they can be skipped entirely (no CS, no row/column commands,
no data).

**Correctness details (important):**

- The map must start as "nothing known blank" (all bits 0) so the first frame
  writes every page.
- The panel retains its RAM while asleep, but the firmware cuts power to the
  LCD via `MCP1256_ENABLE` in the sleep path and on the `s` key. After such a
  power cycle the controller RAM is undefined. Call
  `display_invalidate_panel_state()`:
  - in `display_init()` after reset,
  - when waking (`sleep_mode == MODE_WAKEUP`, after `MCP1256_ENABLE = 1`),
  - when `s` toggles `MCP1256_ENABLE`,
  - conservatively on `U8X8_MSG_DISPLAY_SET_POWER_SAVE`.
- The boot screen writes pages 0–3; switching to the status screen must clear
  those once. The "known blank" state handles this automatically as long as
  the map reflects the last frame actually sent.
- Assumes text is drawn with colour 1 on a cleared (0) buffer. That is the
  current `u8g2` default and `render_status()` does not change the draw
  colour. If the UI ever inverts colours, revisit this check.
- The 360-byte scan per page costs roughly 1–2 ms per frame in total; it is
  dwarfed by the transfers it avoids.

**Expected effect:** ~40 % less data and ~40 % fewer transfers for the status
screen, more for the boot screen.

**Measure and gate:** record the table row. Explicitly test: boot screen →
first keypress; display sleep → wake → keypress; press `s` twice; power cycle.
No stale or missing text allowed in any of those.

### C2 – Optional: full page cache (skip unchanged pages, not just blank ones)

**Status:** deferred. Not implemented; revisit only if the measured numbers
after C1 are still above the acceptance target.

Keep the previous frame's 1-bpp page buffers (`20 × 360 = 7,200 B`) and
`memcmp()` each page; skip pages that are byte-identical. Measured on two
consecutive keypresses with different values:

| Scheme | Pages/rows sent | Data bytes | State required |
|--------|-----------------|------------|----------------|
| none | 20 pages | 19,420 | — |
| C1 blank-page skip | 12 pages | 11,652 | 3 B |
| C2 page cache | 9 pages | 8,739 | 7,200 B |
| dirty-row cache | 48 rows in 5 runs | 5,760 + ~50 B commands | 7,200 B shadow or 640 B CRC-32 |

The extra benefit over C1 is ~25 % of the remaining bytes, for 7.2 KB of RAM.
Given that B already removes most of the per-byte cost, this is **not
recommended now**. It becomes interesting only if transport is still a
significant share after B (and if a full framebuffer is introduced anyway,
see §8). If it is implemented later, the same invalidation rules as C1 apply
(init, wake, `s`, power-save).

**Phase C exit gate:** C1 measured and stable; C2 explicitly deferred unless
the numbers justify it.

---

## 6. Phase D – Transparent font mode

**Status:** implemented in `edc2da2`. Applied to both the status screen and
the boot screen.

**Files:** `src/main.c` (`render_status()` and the boot screen)

```c
u8g2_SetFontMode(&u8g2, 1);   /* transparent; was 0 (solid/opaque) */
```

Or set it once in `display_init()` and remove the per-screen calls, so there
is one place to change.

**Why it is safe:** `u8g2_FirstPage()` clears the whole 360-byte page buffer
before drawing, so the background runs that solid mode paints are already
zero. Output is pixel-identical. (The explicit `u8g2_ClearBuffer()` before
`u8g2_FirstPage()` in `render_status()` is redundant and can be dropped
separately.)

**Measured effect:** `u8g2_DrawHVLine()` calls drop from 6,494 to 3,011
(3,483 background runs eliminated); actual pixel-run writes drop from 2,564 to
1,191.

**Caveat:** if a future change stops clearing the page (e.g. incremental
drawing into a full framebuffer), transparent mode can leave stale glyph
backgrounds. Clear/repaint the changed region in that case.

**Measure and gate:** record the table row. Compare screenshots/visual output
against the previous phase; no ghosting allowed.

---

## 7. Execution order and checkpoints

Recommended order (phase letters follow the analysis above, not necessarily
execution order):

1. **Phase 0** – baseline, release build, 10 presses, table filled in.
   **Not done.**
2. **Phase B1** – blocking SPI. Measure; verify hardware behaviour.
   **Done (`7ca136c`); measurement pending.**
3. **Phase B2** – coalesce to 255-byte transfers. Measure.
   **Done (`58d4c51`); measurement pending.**
4. **Phase C1** – blank-page skip + invalidation hooks. Measure; run the
   wake/power-cycle/`s` tests. **Done (`7a31173`); measurement and the
   wake/power-cycle tests pending.**
5. **Phase D** – transparent font mode. Measure.
   **Done (`edc2da2`); measurement pending.**
6. **Final** – repeat the full hardware checklist below on the release build;
   record final median/min/max and RAM usage. **Pending.**

The actual implementation order was B1 → B2 → C1 → D, so the suggestion to do
the one-line Phase D first was not followed. The phase numbering stays as
originally written (by area).

After B, the remaining phases are measured against a smaller base; 1 ms tick
resolution is still more than adequate.

Estimated ballpark after B + C1 + D (release): roughly **80–160 ms**; treat
this as a target, not a guarantee until the phases are measured. If it is
still above 200 ms, measure the split between drawing and transfer before
adding C2 or E (see §8).

---

## 8. Alternatives considered (and the dirty-row question)

All of these reduce bytes sent, not drawing cost. Ordering by effort:

| Technique | What it skips | Granularity | State / RAM | Measured data for 2 consecutive presses |
|-----------|---------------|-------------|-------------|------------------------------------------|
| C1 blank-page skip | blank pages | 8 rows | 20 bits | 11,652 B (60 %) |
| C2 page cache | blank + unchanged pages | 8 rows | 7,200 B (1-bpp shadow) | 8,739 B (45 %) |
| Dirty-row cache | unchanged rows, inside changed pages too | 1 row | 7,200 B shadow, or 160 × CRC-32 = 640 B | 5,760 B (30 %) + commands |
| Full framebuffer + `u8g2_UpdateDisplayArea()` | unchanged tile rows; also draws text once | 8 rows | 7,200 B buffer (+ shadow/hashes for dirty) | ≈ C2, plus much less drawing |

### Is a dirty row cache better or worse than page caching?

It is the same idea at finer granularity, so it sends fewer bytes, but it is
**more work for a smaller marginal gain**:

- **Pros:** matches the panel's actual update mechanism (ST7586 row address
  window, `0x2B`). With 5 changed runs it can send ~30 % of the frame instead
  of ~45 % (page cache) or ~60 % (blank-page skip).
- **Cons:**
  - Needs previous-frame state: either a 7,200 B 1-bpp shadow or 160 row
    hashes. Use CRC-32 (640 B), not an 8/16-bit checksum — an 8-bit checksum
    collides often enough to leave visible stale rows; a 16-bit CRC at ~48
    changed rows per press is already marginal.
  - The driver has to send multiple row windows per page and pack only the
    selected rows; more code and more ways to get the window arithmetic wrong.
  - More command overhead per run (a row/column window per run), though only
    ~10 bytes each.
  - It does **not** reduce drawing cost: the full 20-page render still
    happens. Blank-page skip at least lets you skip the transfer for a whole
    page.
  - Its benefit depends heavily on the values changing. If `batt` changes
    (it is sampled every press), add a couple more runs; on a contrast change
    or a full-screen update it degenerates to the full frame.
- **Recommendation:** do **not** implement row caching in this plan. First do
  B (the real bottleneck is per-byte overhead, not byte count). If transport
  is still dominant after B + C1, C2 is the cheapest next step. Row-level
  caching only pays off if (a) the UI is mostly static, or (b) a full
  framebuffer is introduced anyway — then use 160 × CRC-32 row hashes rather
  than a 7.2 KB shadow, and reinterpret the row window per changed run.

Other notes:

- **Line-level dirty tracking** (compare the 5 formatted strings) is very
  cheap but weak: every dynamic line changes on a keypress, so only `batt`
  would be skipped. It cannot exploit the static text prefix inside a line
  the way row-level tracking can.
- **1 bpp / monochrome mode** does not help: the ST7586 mono format still
  packs 3 pixels per byte (one bit per pixel, duplicated across 3 bits), so
  the byte count is unchanged.
- **Changing the font** (e.g. 6×10) reduces the number of occupied rows and
  therefore bytes, but changes the UI; out of scope.
- **Drawing only the lines that intersect the current page** (skip the other
  `DrawStr` calls) saves glyph lookups and clipped-glyph tests in page mode;
  it is cheap and compatible with C1/D, but it only addresses the drawing
  share. Add it only if the drawing/transport split says drawing still
  matters after B.

---

## 9. Risks and rollback

| Risk | Mitigation |
|------|-----------|
| Blocking SPI changes timing/interrupt behaviour | Interrupts stay enabled; only the LCD instance changes; EEPROM SPI1 untouched. Measure and test sleep/wake. |
| 255-byte chunk boundary bug (short last chunk) | 960 = 255 + 255 + 255 + 195; assert/verify the last chunk length. Visual check for the rightmost pixels. |
| Stale pixels from blank-page skip | Invalidate on init, wake, `s`, power-save; start with all pages dirty. Test the explicit transitions in §5. |
| Transparent mode ghosts | Page buffer is cleared by `FirstPage()`; verify boot and status screens. Revisit if a framebuffer is added. |
| Debug build confuses measurements | Always record build type; use release for headline numbers. |
| RAM growth | +960 B for B2; C1 +3 B. C2 would add 7,200 B and is deferred. |

Each phase is independently revertible; there are no data-format or API
changes outside the display module.

---

## 10. Final hardware verification checklist

Run this on the release build, after all phases. Status as of 2026-10-31 is
marked per item; nothing below has been visually checked on the panel yet.

1. **Boot:** RF channel / IC revision / flash / RAM lines and "Hello lcd" are
   correct; no leftover pixels from the previous frame.
   **Partial:** the release image runs past the boot draw into the main loop
   (verified with a debugger after `3e9964e`); pixel-level check pending.
2. **First keypress:** full status screen appears, all 5 lines correct, no
   torn or missing glyphs. **Pending (needs a manual keypress).**
3. **Several keys:** char/tick/elapsed/batt/delay update; no stale text in the
   blank bands. **Pending.**
4. **Left/right arrows:** contrast steps still work (these use the same SPI
   byte callback via `display_contrast_set()`). **Pending.**
5. **`s` key:** LCD regulator toggles; after toggling back on, the next
   keypress must repaint every page (invalidation works). **Pending.**
6. **Sleep:** leave idle past `SLEEP_BACKLIGHT_DELAY`/`SLEEP_DISPLAY_DELAY`;
   wake with a key; screen repaints correctly (no ghosting from the blank-page
   map). **Pending.**
7. **Reset/power cycle:** boot screen and first status screen correct.
   **Pending.**
8. **EEPROM scan at boot still succeeds (SPI1 unaffected).** **Partial:** the
   release image reaches the main loop, which is only possible after the scan
   completes; the scan result itself was not inspected.
9. **Record final `delay:` median/min/max and the linker RAM usage
   (`data + bss`), then update this document's table and status.**
   **Partial:** RAM is 3,872 B (`data` 556 + `bss` 3,316) in the last release
   build; the delay values are not recorded yet.

---

## 11. Appendix: transfer math

- 340 visible pixels (the driver currently sends 360 px / 120 triple-columns).
- 3 pixels per byte in 2-bit grey format → 120 bytes per row.
- Page = 8 rows → 960 bytes.
- 20 pages → 19,200 bytes + 11 command/arg bytes per page = 19,420 bytes.
- At 8 MHz: 19,420 × 8 / 8,000,000 ≈ 19.4 ms of bus time.
- 2,400 data calls of 8 bytes; with B2, 4 calls of 255/255/255/195 per page.
- Expected transfer counts:
  - pre-change: 2,400 data + 220 cmd/arg = 2,620
  - B2: 80 data + 220 cmd/arg = 300
  - B2 + optional cmd/arg coalescing (not implemented): 80 + 20 = 100
  - with C1 on the status screen: 12/20 of those.

## 12. Appendix: how the offline counts were obtained

A throwaway host build (outside the repo) compiled the same u8g2 sources and
`src/u8x8_d_st7586_rcqr01.c`, installed a no-op byte callback, and ran the
identical `render_status()` page loop with representative values. Counters
were added to `u8g2_font_decode_len`, `u8g2_DrawHVLine` and the byte callback.
This gives the exact page/transfer/draw-call counts used above without needing
hardware. The harness is not part of the repository; recreate it if the
numbers need to be re-verified after code changes.

---

## 13. Implementation notes and deviations

### What landed

- **B1** (`7ca136c`): SPI0 (LCD) is initialized with a `NULL` handler, so
  `nrf_drv_spi_transfer()` runs in blocking/polling mode. `SPI1` (EEPROM) keeps
  its event handler and `volatile` flag.
- **B2** (`58d4c51`): a 960-byte static `page_out[]` staging buffer expands one
  page and sends it as 255/255/255/195-byte chunks. Static RAM grew to 3,872 B
  (`data` 556 + `bss` 3,316); no heap.
- **C1** (`7a31173`): the three-byte `blank_pages[]` map skips pages that were
  blank in the last frame actually sent. `display_invalidate_panel_state()` is
  called from `display_init()`, the `MODE_WAKEUP` path, the `s` key, and
  `U8X8_MSG_DISPLAY_SET_POWER_SAVE`.
- **D** (`edc2da2`): `u8g2_SetFontMode(&u8g2, 1)` is used on both the status
  and boot screens.

### Deviations and non-goals

- The optional command/argument coalescing from the B2 notes was not
  implemented.
- C2 (page cache) remains deferred; no 7.2 KB shadow was added.
- The redundant `u8g2_ClearBuffer()` before `u8g2_FirstPage()` in
  `render_status()` is still present. It is harmless; removing it is an
  optional cleanup, not part of the acceptance criteria.
- Implementation order was B1 → B2 → C1 → D, not D first as suggested in §7.
- **Release-build blocker fixed along the way:** the release build used to
  hard-fault in `radio_init()` because the ESB code read `m_esb_addr` with an
  unaligned 32-bit load (`m_esb_addr` landed at `0x20000039` with `-Os`;
  `-Og` happened to align it). This is unrelated to display latency, but the
  release build could not be exercised until it was fixed. Fixed in `3e9964e`
  through `scripts/setup_sdk.py` and
  `patches/0003-fix-nrf_esb-unaligned-access.patch`.
- Repository line endings were normalized to LF (`c9ed420`); no functional
  effect.

### Verification state (2026-10-31)

Verified:

- The release build compiles; the debug build also built during the
  investigation (before the ESB fix was applied). Last release image:
  RAM 3,872 B, flash ~25.3 KB (25,260 B).
- On hardware, the release image built after `3e9964e` completes startup,
  performs the boot draw, and reaches the `__WFE`/`__SEV` main loop without a
  HardFault or reset loop.
- The patched `bytewise_bit_swap()` disassembles to byte loads (`ldrb`), and
  `m_esb_addr` was still at the odd address `0x20000039`, so the fix does not
  depend on link layout.
- With no RTT host attached the 256-byte up-buffer fills and later `NRF_LOG`
  messages are skipped (default non-blocking mode). In the observed run RTT
  stopped after `radio initialized`; that is expected and is not a hang.

Still outstanding:

- A release-build Phase 0 baseline and post-phase measurements (10 presses
  each, discard the first) to fill the §3 table.
- The §10 hardware checklist (keypress redraws, contrast, `s`, sleep/wake,
  reset, EEPROM scan, visual ghosting checks).
- Only then can the ≤ 200 ms acceptance criterion and the plan status be
  marked complete.
