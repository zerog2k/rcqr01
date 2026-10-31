# Product: RCQR-01 Demo Software

Reverse-engineering and exploration firmware for the **Turning Technologies RCQR-01** — a "clicker" style audience response device.

## What it does
- Drives the RCQR-01 hardware: LCD display, 8×8 keypad, SPI EEPROM, and 2.4 GHz radio
- Demonstrates display rendering, key scanning, radio transmission, and power/sleep management
- Acts as a transmitter (PTX) sending keystrokes over Nordic ESB radio

## Hardware summary
- **MCU**: Nordic nRF51822 (Cortex-M0, 16 KB RAM, 256 KB flash) — the low-RAM variant is a key constraint
- **Display**: ~360×160 LCD with ST7586 controller; unusual 3 pixels-per-byte (2-bit grayscale) format; driven via SPI; uses a 1bpp framebuffer flushed periodically
- **Keypad**: 8×8 matrix, QWERTY layout, rows have external pull-ups
- **EEPROM**: CAT25512 512 Kb, SPI interface
- **Radio**: Nordic ESB (Enhanced ShockBurst) proprietary RF, 2 Mbps
- **Power**: MCP1256 boost converter/regulator for LCD and backlight; low-power PWM for backlight dimming; `__WFE` sleep in main loop

## Status
Work-in-progress / personal exploration project. No production or safety requirements.
