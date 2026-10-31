/*
 * Board glue for the RCQR-01 ST7586 display (nRF51822 + HW SPI).
 *
 * The uGFX-era board file was replaced by this plain C header; the
 * display-specific GPIO handling lives in u8g2_nrf51.c and the controller
 * driver in u8x8_d_st7586_rcqr01.c.
 */

#ifndef _BOARD_ST7586_H
#define _BOARD_ST7586_H

#include <stdbool.h>
#include "nrf_gpio.h"
#include "nrf_delay.h"
#include "nrf_drv_spi.h"
#include "app_error.h"

#define LCD_SCK     7
#define LCD_MISO    4
#define LCD_MOSI    5
#define LCD_CS      1
#define LCD_DC      3
#define LCD_RST     2
#define LCD_RW      6

#define SPI_INSTANCE  0 /**< SPI instance index. */
extern const nrf_drv_spi_t spi; /**< defined in u8g2_nrf51.c */

/* configure display control pins, pulse the hardware reset,
   and initialise the nrf_drv_spi instance */
void st7586_board_init(void);

#endif /* _BOARD_ST7586_H */
