/*
 * This file is subject to the terms of the GFX License. If a copy of
 * the license was not distributed with this file, you can obtain one at:
 *
 *              http://ugfx.org/license.html
 */

#ifndef _GDISP_LLD_BOARD_H
#define _GDISP_LLD_BOARD_H

#include "nrf_gpio.h"
#include "nrf_drv_spi.h"
#include "nrf_delay.h"
#include "nrf_log.h"
#include "app_error.h"

#define LCD_SCK     7
#define LCD_MISO    4
#define LCD_MOSI    5
#define LCD_CS      1
#define LCD_DC      3
#define LCD_RST     2
#define LCD_RW      6

#define SPI_INSTANCE  0 /**< SPI instance index. */
static const nrf_drv_spi_t spi = NRF_DRV_SPI_INSTANCE(SPI_INSTANCE);  /**< SPI instance. */
nrf_drv_spi_config_t spi_config = NRF_DRV_SPI_DEFAULT_CONFIG;
static volatile bool spi_xfer_done;  /**< Flag used to indicate that SPI instance completed the transfer. */

void spi_event_handler(nrf_drv_spi_evt_t const * p_event)
{
    spi_xfer_done = true;
    //NRF_LOG_DEBUG("spi transfer completed.\n");
}

static GFXINLINE void init_board(GDisplay *g) {
  NRF_LOG_INFO("init_board\n");
  // setup pins
  nrf_gpio_cfg_output(LCD_CS);
  nrf_gpio_cfg_output(LCD_DC);
  nrf_gpio_cfg_output(LCD_RST);
  nrf_gpio_cfg_output(LCD_RW);

  nrf_gpio_pin_write(LCD_CS, 1);
  nrf_gpio_pin_write(LCD_RW, 1);

  // reset board
  nrf_gpio_pin_write(LCD_RST, 0);
  nrf_delay_ms(100);
  nrf_gpio_pin_write(LCD_RST, 1);

  // setup spi
  spi_config.miso_pin = LCD_MISO;
  spi_config.mosi_pin = LCD_MOSI;
  spi_config.sck_pin  = LCD_SCK;
  spi_config.frequency = NRF_DRV_SPI_FREQ_8M;
  APP_ERROR_CHECK(nrf_drv_spi_init(&spi, &spi_config, spi_event_handler));

	(void) g;
}

static GFXINLINE void post_init_board(GDisplay *g) {
	(void) g;
}

static GFXINLINE void setpin_reset(GDisplay *g, bool_t state) {
  NRF_LOG_INFO("setpin_reset: %d\n", state);
    nrf_gpio_pin_write(LCD_RST, state);
	(void) g;
	(void) state;
}

static GFXINLINE void acquire_bus(GDisplay *g) {
  // cs active
  nrf_gpio_pin_write(LCD_CS, 0);
	(void) g;
}

static GFXINLINE void release_bus(GDisplay *g) {
 // cs inactive
 nrf_gpio_pin_write(LCD_CS, 1);
	(void) g;
}

static GFXINLINE void write_cmd(GDisplay *g, uint8_t cmd) {
  // dc low
  nrf_gpio_pin_write(LCD_DC, 0);
  spi_xfer_done = false;
  APP_ERROR_CHECK(nrf_drv_spi_transfer(&spi, &cmd, 1, NULL, 0));
  while (!spi_xfer_done);
	(void) g;
	(void) cmd;
}

static GFXINLINE void write_arg(GDisplay *g, uint8_t arg) {
  // dc high
  nrf_gpio_pin_write(LCD_DC, 1);
  spi_xfer_done = false;
  APP_ERROR_CHECK(nrf_drv_spi_transfer(&spi, &arg, 1, NULL, 0));
  while (!spi_xfer_done);
	(void) g;
	(void) arg;
}

static GFXINLINE void write_data(GDisplay *g, uint8_t* data, uint16_t length) {
  // dc high
	(void) g;
	(void) data;
	(void) length;
  nrf_gpio_pin_write(LCD_DC, 1);
  spi_xfer_done = false;
  //APP_ERROR_CHECK(nrf_drv_spi_transfer(&spi, data, length, NULL, 0));
  nrf_drv_spi_transfer(&spi, data, length, NULL, 0);
  while (!spi_xfer_done);
}


#endif /* _GDISP_LLD_BOARD_H */
