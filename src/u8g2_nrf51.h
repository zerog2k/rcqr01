#ifndef _U8G2_NRF51_H
#define _U8G2_NRF51_H

#include "clib/u8g2.h"

uint8_t u8x8_gpio_and_delay_nrf51(u8x8_t *u8x8, uint8_t msg, uint8_t arg_int, void *arg_ptr);
uint8_t u8x8_byte_nrf51_hw_spi(u8x8_t *u8x8, uint8_t msg, uint8_t arg_int, void *arg_ptr);

#endif /* _U8G2_NRF51_H */
