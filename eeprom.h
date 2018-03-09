// eeprom functions for CAT25512
// datasheet: http://www.onsemi.com/pub/Collateral/CAT25512-D.PDF

#include "nrf_gpio.h"
#include "nrf_drv_spi.h"
#include "nrf_delay.h"
#include "nrf_log.h"
#include "app_error.h"

// eeprom pins
#define EEP_CS  12
#define EEP_SO  16
#define EEP_SI  30
#define EEP_CK   0

// opcodes
#define WREN  0b00000110  // enable write operation
#define WRDI  0b00000100  // disable write operation
#define RDSR  0b00000101  // read status register
#define WRSR  0b00000001  // write status register
#define READ  0b00000011  // read data from memory
#define WRITE 0b00000010  // write data to memory

// status register bit positions
#define WPEN  7
#define IPL   6
#define LIP   4
#define BP1   3
#define BP0   2
#define WEL   1
#define NRDY  0

#define SPI_INSTANCE  1 /**< SPI instance index. */
static const nrf_drv_spi_t spi = NRF_DRV_SPI_INSTANCE(SPI_INSTANCE);  /**< SPI instance. */
static nrf_drv_spi_config_t spi_config = NRF_DRV_SPI_DEFAULT_CONFIG;
static volatile bool spi_xfer_done;  /**< Flag used to indicate that SPI instance completed the transfer. */

static void spi_event_handler(nrf_drv_spi_evt_t const * p_event)
{
    spi_xfer_done = true;
    //NRF_LOG_DEBUG("spi transfer completed.\n");
}

static void eeprom_init(void) 
{
  // setup spi
  spi_config.miso_pin = EEP_SO;
  spi_config.mosi_pin = EEP_SI;
  spi_config.sck_pin  = EEP_CK;
  spi_config.ss_pin   = EEP_CS;
  spi_config.frequency = NRF_DRV_SPI_FREQ_125K;

  APP_ERROR_CHECK(nrf_drv_spi_init(&spi, &spi_config, spi_event_handler));
}

static void _write_byte(uint8_t b) 
{
  spi_xfer_done = false;
  APP_ERROR_CHECK(nrf_drv_spi_transfer(&spi, &b, 1, NULL, 0));
  while (!spi_xfer_done);
}

static uint8_t _read_byte(void)
{
  uint8_t b;
  spi_xfer_done = false;
  APP_ERROR_CHECK(nrf_drv_spi_transfer(&spi, NULL, 0, &b, 1));
  while (!spi_xfer_done);
  return b;
}

static void _write_data(uint8_t* data, uint16_t length) 
{
  spi_xfer_done = false;
  APP_ERROR_CHECK(nrf_drv_spi_transfer(&spi, data, length, NULL, 0));
  //nrf_drv_spi_transfer(&spi, data, length, NULL, 0);
  while (!spi_xfer_done);
}


uint8_t eeprom_read(uint16_t addr, uint8_t len, uint8_t * buf)
{
  uint8_t txbuf[3] = { READ, addr >> 8, addr & 0xFF };
  uint8_t rxbuf[3+len];
  spi_xfer_done = false;
  APP_ERROR_CHECK(nrf_drv_spi_transfer(&spi, txbuf, 3, rxbuf, len+3));
  while (!spi_xfer_done);
  memcpy(buf, rxbuf+3, len);
}

void eeprom_write(uint16_t addr, uint8_t len, uint8_t * buf)
{
  uint8_t txbuf[3+len];
  txbuf[0] = WRITE;
  txbuf[1] = addr >> 8;
  txbuf[2] = addr & 0xFF;
  memcpy(txbuf+3, buf, len);
  spi_xfer_done = false;
  APP_ERROR_CHECK(nrf_drv_spi_transfer(&spi, txbuf, 3+len, NULL, 0));
  while (!spi_xfer_done);
}

uint8_t eeprom_read_sr(void)
{
  uint8_t cmd = RDSR;
  uint8_t sr[2];
  spi_xfer_done = false;
  APP_ERROR_CHECK(nrf_drv_spi_transfer(&spi, &cmd, 1, sr, 2));
  while (!spi_xfer_done);
  return sr[1];
}

void eeprom_write_sr(uint8_t reg)
{
  uint8_t cmd[2] = { WRSR, reg };
  spi_xfer_done = false;
  APP_ERROR_CHECK(nrf_drv_spi_transfer(&spi, cmd, 2, NULL, 0));
  while (!spi_xfer_done);
}

void eeprom_write_enable(void)
{
  uint8_t cmd = WREN;
  spi_xfer_done = false;
  APP_ERROR_CHECK(nrf_drv_spi_transfer(&spi, &cmd, 1, NULL, 0));
  while (!spi_xfer_done);
}

