// Turning Technologies RCQR-01 demo app
// Jens Jensen 2017

// SDK 12.3.0 docs link: http://infocenter.nordicsemi.com/topic/com.nordic.infocenter.sdk5.v12.3.0/index.html

#include <stdbool.h>
#include <stdint.h>
#include "nrf.h"
#include "nrf_delay.h"
#include "nrf_gpio.h"
#include "nrf_log.h"
#include "nrf_log_ctrl.h"
#include "SEGGER_RTT.h"

#include "radio.h"
#include "apptimers.h"
#include "gfx.h"
#include "ST7586.h"
#include "adc_hal.h"

#include "keypad.h"

#include "nrf_ic_info.h"
nrf_ic_info_t *nrf_info;

// eeprom pins
#define EEP_CS  12
#define EEP_SO  16
#define EEP_SI  30
#define EEP_CK   0

#define LCD_BACKLIGHT 13
// LDO control pins
#define MCP1256_PGOOD 14
#define MCP1256_SLEEP 15
#define MCP1256_SHUTDOWN  27

uint32_t elapsed, drawdelay = 0;

uint8_t i, c, lopin;

systemticks_t gfxSystemTicks(void)
{
	return tick;
}

systemticks_t gfxMillisecondsToTicks(delaytime_t ms)
{
	return ms;
}

font_t font_small, font_med;


int main(void)
{

  keypad_init();

  // setup led/lcd/ldo

  nrf_gpio_cfg_output(MCP1256_SLEEP);
  nrf_gpio_cfg_output(MCP1256_SHUTDOWN);
  nrf_gpio_pin_write(MCP1256_SLEEP, 1);
  nrf_gpio_pin_write(MCP1256_SHUTDOWN, 1);
  nrf_gpio_cfg_output(LCD_BACKLIGHT);
  nrf_gpio_pin_write(LCD_BACKLIGHT, 1);

  NRF_LOG_INIT(NULL);
  tick_init();
 
  gfxInit();
  font_small = gdispOpenFont("fixed_7x14");
  font_med = gdispOpenFont("fixed_10x20");

  //gdispControl(GDISP_CONTROL_ALL_PIXELS, 1);
  //gdispSetPowerMode(powerOn);
  
  char sbuf[128];
  
  sprintf(sbuf, "RFCH:%02d", get_channel());
  gdispDrawString(0,0, sbuf, font_small, White);

  nrf_ic_info_get(nrf_info);
  sprintf(sbuf, "did1: 0x%x, did0: 0x%x, fl: %d, rb: %d", NRF_FICR->DEVICEID[1], NRF_FICR->DEVICEID[0], nrf_info->flash_size,  NRF_FICR->NUMRAMBLOCK);
  gdispDrawString(0,20, sbuf, font_small, White);   
   
   /*
   // some test graphics...
   gdispFillCircle(80, 80, 10, White);
   gdispDrawBox(0, 00, 10, 10, White);
   gdispDrawBox(330, 00, 10, 10, White);
   gdispDrawBox(0, 140, 20, 20, White);
  */

  gdispDrawString(0,40, "Hello lcd", font_med, White);
  gdispFlush();

  radio_init();
  adc_init();

  /// LOOP
  while (true)
  {

    NRF_LOG_DEBUG("tick: %d\n", tick);
    //gdispControl(GDISP_CONTROL_INVERSE, 1);
    //gfxSleepMilliseconds(1000);
    //gdispControl(GDISP_CONTROL_INVERSE, 0);
    nrf_delay_ms(50);

    elapsed = tick;

    c = scan_keypad();
    if (c) 
    {
      sprintf(sbuf, "char: %c", c);
      gdispFillString(0,130, sbuf, font_med, White, Black);
      // send char over radio
      send_char(c);
      switch (c) {
         case 0xc1:
          // config button
          nrf_gpio_pin_toggle(LCD_BACKLIGHT);
          break;
         case 's':
          // shutdown ldo to turn off lcd & led
          nrf_gpio_pin_toggle(MCP1256_SHUTDOWN);
          break;
      }
    }
    
    elapsed = tick - elapsed;

    sprintf(sbuf, "hello lcd land, tick: %8d", tick);
    gdispFillString(0, 40, sbuf, font_med, White, Black);

    sprintf(sbuf, "elapsed: %8d", elapsed);
    gdispFillString(0, 60, sbuf, font_med, White, Black);

    sprintf(sbuf, "batt: %3d", get_vcc());
    gdispFillString(0, 80, sbuf, font_med, White, Black);

    sprintf(sbuf, "draw delay: %d, RADIO: %x", drawdelay, NRF_RADIO->STATE);
    gdispFillString(0,110, sbuf, font_med, White, Black);

    if (c | elapsed > 10000)
    {
      drawdelay = tick;
      gdispFlush();
      drawdelay = tick - drawdelay;
    }

    // cpu sleep
    __WFI();
    __NOP();

  }

}

/**
 *@}
 **/
