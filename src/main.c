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

uint8_t rowidx, row, colidx, col, pressed = 0;

uint32_t gpio_state, prev_state, state_diff, init_state, init_diff = 0;
uint32_t elapsed, drawdelay = 0;

uint8_t i, lopin;

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

  // initially tristate all col/row pins
  nrf_gpio_range_cfg_input(8, 31, NRF_GPIO_PIN_NOPULL);

  // set cols to inputs, pulldown
  for (i=0; i < sizeof(col_pins); i++)
    nrf_gpio_cfg_input(col_pins[i], NRF_GPIO_PIN_PULLUP);

  // set rows to inputs, pullups (have external pullups)
  for (i=0; i < sizeof(row_pins); i++)
    nrf_gpio_cfg_input(row_pins[i], NRF_GPIO_PIN_PULLUP);
  
  //nrf_gpio_range_cfg_output(17, 24, NRF_GPIO_PIN_NOPULL);

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

  nrf_ic_info_get(nrf_info);
   char sbuf[128];
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

  init_state = nrf_gpio_port_in_read(NRF_GPIO) & colmask;

  radio_init();
  adc_init();

  /// LOOP
  while (true)
  {

    //nrf_gpio_pin_toggle(LCD_BACKLIGHT);
    NRF_LOG_DEBUG("tick: %d\n", tick);
    //gdispControl(GDISP_CONTROL_INVERSE, 1);
    //gfxSleepMilliseconds(1000);
    //gdispControl(GDISP_CONTROL_INVERSE, 0);
    nrf_delay_ms(30);

    elapsed = tick;

    // scan keypad, loop through rows
    pressed = 0;
    for (rowidx=0; rowidx < ROW_SIZE; rowidx++)
    {
      // set row to output low
      row = row_pins[rowidx];
      nrf_gpio_cfg_output(row);
      nrf_gpio_pin_write(row, 0);
      // find col set low
      for (colidx=0; colidx < COL_SIZE; colidx++)
      {
        col = col_pins[colidx];
        if (nrf_gpio_pin_read(col) == 0)
        {
          pressed++;
          break;
        }
      }

      // set row back to input pullup
      nrf_gpio_cfg_input(row, NRF_GPIO_PIN_PULLUP);
      
      if (pressed)
      {
        // keypress found, print col & row
        uint8_t c = get_key_char_from_table(colidx, rowidx);
        sprintf(sbuf, "col: %02d, row: %02d, c: %c", colidx, rowidx, c);
        NRF_LOG_INFO("col: %02d, row: %02d\n", col, row);
        gdispFillString(0,130, sbuf, font_med, White, Black);
        // send char over radio
        send_char(c);
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

    sprintf(sbuf, "draw delay: %d", drawdelay);
    gdispFillString(0,110, sbuf, font_med, White, Black);

    if (pressed | elapsed > 10000)
    {
      drawdelay = tick;
      gdispFlush();
      drawdelay = tick - drawdelay;
    }

    prev_state = gpio_state;
  }

}

/**
 *@}
 **/
