/**
 * Copyright (c) 2014 - 2017, Nordic Semiconductor ASA
 * 
 * All rights reserved.
 * 
 * Redistribution and use in source and binary forms, with or without modification,
 * are permitted provided that the following conditions are met:
 * 
 * 1. Redistributions of source code must retain the above copyright notice, this
 *    list of conditions and the following disclaimer.
 * 
 * 2. Redistributions in binary form, except as embedded into a Nordic
 *    Semiconductor ASA integrated circuit in a product or a software update for
 *    such product, must reproduce the above copyright notice, this list of
 *    conditions and the following disclaimer in the documentation and/or other
 *    materials provided with the distribution.
 * 
 * 3. Neither the name of Nordic Semiconductor ASA nor the names of its
 *    contributors may be used to endorse or promote products derived from this
 *    software without specific prior written permission.
 * 
 * 4. This software, with or without modification, must only be used with a
 *    Nordic Semiconductor ASA integrated circuit.
 * 
 * 5. Any software provided in binary form under this license must not be reverse
 *    engineered, decompiled, modified and/or disassembled.
 * 
 * THIS SOFTWARE IS PROVIDED BY NORDIC SEMICONDUCTOR ASA "AS IS" AND ANY EXPRESS
 * OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED WARRANTIES
 * OF MERCHANTABILITY, NONINFRINGEMENT, AND FITNESS FOR A PARTICULAR PURPOSE ARE
 * DISCLAIMED. IN NO EVENT SHALL NORDIC SEMICONDUCTOR ASA OR CONTRIBUTORS BE
 * LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR
 * CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE
 * GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION)
 * HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT
 * LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT
 * OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
 * 
 */

/** @file
 *
 * @defgroup blinky_example_main main.c
 * @{
 * @ingroup blinky_example
 * @brief Blinky Example Application main file.
 *
 * This file contains the source code for a sample application to blink LEDs.
 *
 */
#define NRF51 1

#include <stdbool.h>
#include <stdint.h>
#include "nrf.h"
#include "nrf_delay.h"
#include "nrf_gpio.h"
#include "nrf_log.h"
#include "nrf_log_ctrl.h"
#include "SEGGER_RTT.h"

#include "gfx.h"
#include "ST7586.h"
#include "apptimers.h"

#include "nrf_ic_info.h"
nrf_ic_info_t *nrf_info;

#define LCD_BACKLIGHT 13
#define MCP1256_SLEEP 15
#define MCP1256_SHUTDOWN  27

systemticks_t gfxSystemTicks(void)
{
	return tick;
}

systemticks_t gfxMillisecondsToTicks(delaytime_t ms)
{
	return ms;
}

font_t font_small, font_med;

/**
 * @brief Function for application main entry.
 */
int main(void)
                                   {
    /* Configure board. */
  
  nrf_gpio_cfg_output(LCD_BACKLIGHT);
  nrf_gpio_cfg_output(MCP1256_SLEEP);
  nrf_gpio_cfg_output(MCP1256_SHUTDOWN);
  nrf_gpio_pin_write(MCP1256_SLEEP, 1);
  nrf_gpio_pin_write(MCP1256_SHUTDOWN, 1);
  NRF_LOG_INIT(NULL);
  tick_init();
  nrf_gpio_pin_write(LCD_BACKLIGHT, 1);

  gfxInit();
  font_small = gdispOpenFont("fixed_7x14");
  font_med = gdispOpenFont("fixed_10x20");

  //gdispControl(GDISP_CONTROL_ALL_PIXELS, 1);
  //gdispSetPowerMode(powerOn);

  nrf_ic_info_get(nrf_info);
   nrf_delay_ms(500);
   char info[128];
   sprintf(info, "icrev: %d, ram: %d, flash: %d, ramblks: %d", NRF_FICR->DEVICEID, nrf_info->ram_size, nrf_info->flash_size,  NRF_FICR->NUMRAMBLOCK);
   gdispDrawString(24,20, info, font_small, White);
   //gdispDrawString(24,30, "Hello lcd world", font, White);

   //gdispFillCircle(20, 20, 10, White);
   gdispDrawBox(22, 00, 10, 10, White);
   gdispDrawBox(352, 00, 10, 10, White);
   gdispDrawBox(22, 140, 20, 20, White);
   gdispFlush();
  /* Toggle LEDs. */
  while (true)
  {
    //nrf_gpio_pin_toggle(LCD_BACKLIGHT);
    NRF_LOG_DEBUG("tick: %d\n", tick);
    //gdispControl(GDISP_CONTROL_INVERSE, 1);
    //gfxSleepMilliseconds(500);
    //gdispControl(GDISP_CONTROL_INVERSE, 0);
    nrf_delay_ms(200);
    
  }
}

/**
 *@}
 **/
