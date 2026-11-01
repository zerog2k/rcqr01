#include "u8g2_nrf51.h"
#include <stdbool.h>
#include "nrf_gpio.h"
#include "nrf_delay.h"
#include "nrf_drv_spi.h"
#include "board_ST7586.h"

/* The single HW SPI instance used by the LCD (and EEPROM, see eeprom.h). */
const nrf_drv_spi_t spi = NRF_DRV_SPI_INSTANCE(SPI_INSTANCE);

void st7586_board_init(void)
{
    // setup pins
    nrf_gpio_cfg_output(LCD_CS);
    nrf_gpio_cfg_output(LCD_DC);
    nrf_gpio_cfg_output(LCD_RST);
    nrf_gpio_cfg_output(LCD_RW);

    nrf_gpio_pin_write(LCD_CS, 1);
    nrf_gpio_pin_write(LCD_RW, 1);

    // reset board
    nrf_gpio_pin_write(LCD_RST, 0);
    nrf_delay_ms(20);
    nrf_gpio_pin_write(LCD_RST, 1);
    nrf_delay_ms(20);

    // setup spi
    nrf_drv_spi_config_t spi_config = NRF_DRV_SPI_DEFAULT_CONFIG;
    spi_config.miso_pin = LCD_MISO;
    spi_config.mosi_pin = LCD_MOSI;
    spi_config.sck_pin  = LCD_SCK;
    spi_config.frequency = NRF_DRV_SPI_FREQ_8M;
    /* No event handler: the SDK driver then runs nrf_drv_spi_transfer() in
       blocking (polling) mode, keeping interrupts to the SPI instance off
       while the transfer still blocks until every byte is clocked out. */
    APP_ERROR_CHECK(nrf_drv_spi_init(&spi, &spi_config, NULL));
}

uint8_t u8x8_gpio_and_delay_nrf51(u8x8_t *u8x8, uint8_t msg, uint8_t arg_int, void *arg_ptr) {
    switch (msg) {
        case U8X8_MSG_GPIO_AND_DELAY_INIT:
            nrf_gpio_cfg_output(u8x8->pins[U8X8_PIN_CS]);
            nrf_gpio_cfg_output(u8x8->pins[U8X8_PIN_DC]);
            nrf_gpio_cfg_output(u8x8->pins[U8X8_PIN_RESET]);
            break;
        case U8X8_MSG_GPIO_CS:
            nrf_gpio_pin_write(u8x8->pins[U8X8_PIN_CS], arg_int);
            break;
        case U8X8_MSG_GPIO_DC:
            nrf_gpio_pin_write(u8x8->pins[U8X8_PIN_DC], arg_int);
            break;
        case U8X8_MSG_GPIO_RESET:
            nrf_gpio_pin_write(u8x8->pins[U8X8_PIN_RESET], arg_int);
            break;
        case U8X8_MSG_DELAY_MILLI:
            nrf_delay_ms(arg_int);
            break;
        case U8X8_MSG_DELAY_10MICRO:
            nrf_delay_us(arg_int * 10);
            break;
        default:
            return 0;
    }
    return 1;
}

uint8_t u8x8_byte_nrf51_hw_spi(u8x8_t *u8x8, uint8_t msg, uint8_t arg_int, void *arg_ptr) {
    switch (msg) {
        case U8X8_MSG_BYTE_SEND:
            /* NULL handler -> the SDK polls EVENTS_READY internally and only
               returns once the whole transfer is complete; errors other than
               success (e.g. NRF_ERROR_BUSY, impossible in this
               single-threaded path) reset via the app error handler. */
            APP_ERROR_CHECK(nrf_drv_spi_transfer(&spi, (uint8_t *)arg_ptr,
                                                 arg_int, NULL, 0));
            break;
        case U8X8_MSG_BYTE_SET_DC:
            nrf_gpio_pin_write(u8x8->pins[U8X8_PIN_DC], arg_int);
            break;
        case U8X8_MSG_BYTE_START_TRANSFER:
            /* Assert CS. Without this u8g2 sends command/data bytes while the
               panel is deselected and the display ignores the whole init
               sequence as well as every subsequent tile write. */
            u8x8_gpio_SetCS(u8x8, u8x8->display_info->chip_enable_level);
            break;
        case U8X8_MSG_BYTE_END_TRANSFER:
            u8x8_gpio_SetCS(u8x8, u8x8->display_info->chip_disable_level);
            break;
        case U8X8_MSG_BYTE_INIT:
            /* SPI itself is initialized by st7586_board_init(); make sure
               the panel starts out deselected. */
            u8x8_gpio_SetCS(u8x8, u8x8->display_info->chip_disable_level);
            break;
        default:
            return 0;
    }
    return 1;
}
