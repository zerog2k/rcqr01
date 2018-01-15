
// SDK 12.3.0 docs link: http://infocenter.nordicsemi.com/topic/com.nordic.infocenter.sdk5.v12.3.0/index.html

#define NRF51 1

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
#include "vcc.h"

#include "nrf_ic_info.h"
nrf_ic_info_t *nrf_info;

// eeprom pins
#define EEP_CS  12
#define EEP_SO  16
#define EEP_SI  30
#define EEP_CK   0

#define LCD_BACKLIGHT 13
#define MCP1256_PGOOD 14
#define MCP1256_SLEEP 15
#define MCP1256_SHUTDOWN  27

// port mask for keypad matrix
#define KEY_MASK 0x37FE0F00

uint8_t matrixpins[] = { 8, 9, 10, 11, 17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 28, 29 };

#define ROW_SIZE  8
#define COL_SIZE  8
const uint8_t row_pins[ROW_SIZE] = { 8, 18, 19, 20, 21, 22, 23, 24 }; // have external pullups
const uint32_t rowmask = (1 << 8) | (1 << 18) | (1 << 19) | (1 << 20) | (1 << 21) | (1 << 22) | (1 << 23) | (1 << 24);
const uint8_t col_pins[COL_SIZE] = { 9, 10, 11, 17, 25, 26, 28, 29 }; 
const uint32_t colmask = (1 << 9) | (1 << 10) | (1 << 11) | (1 << 17) | (1 << 25) | (1 << 26) | (1 << 28) | (1 << 29);

const char keytab[64] = {   0x65, 0x73, 0x64, 0x78, 0xf2, 0x32, 0x33, 0x77,
                            0x72, 0x66, 0x76, 0x63, 0xf3, 0xd3, 0xd1, 0x34,
                            0x61, 0x7a, 0x5e, 0x25, 0xf1, 0xc0, 0x31, 0x71,
                            0x70, 0x2b, 0x08, 0x0a, 0xf5,  0x0, 0xc1, 0x30,
                            0x68, 0x6e, 0x20,  0x0, 0xf4, 0xd2, 0x36, 0x79,
                            0x74, 0x67, 0x62,  0x0,  0x0, 0xd0, 0xd4, 0x35,
                            0x6a, 0x6d, 0x2c,  0x0,  0x0,  0x0, 0x37, 0x75,
                            0x69, 0x6b, 0x6c, 0x2e,  0x0, 0x38, 0x39, 0x6f  };

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


uint8_t bitpos(uint32_t input)
{
  uint8_t i;
  for (i=0; i < 32; i++)
  {
    if (input & 1)
      return i;
    else 
      input >>= 1;
  }
  return 255; // not found
}


char get_key_char_from_table(uint8_t col, uint8_t row)
{
  uint8_t idx = (col * 8) + row;
  return keytab[idx];
}

/**
 * @brief Function for application main entry.
 */
int main(void)
{
    /* Configure board. */
  

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
   gdispFillCircle(80, 80, 10, White);
   gdispDrawBox(0, 00, 10, 10, White);
   gdispDrawBox(330, 00, 10, 10, White);
   gdispDrawBox(0, 140, 20, 20, White);
  */

  gdispDrawString(0,40, "Hello lcd", font_med, White);
  gdispFlush();

  init_state = nrf_gpio_port_in_read(NRF_GPIO) & colmask;

  radio_init();

  /// LOOP
  while (true)
  {

    //nrf_gpio_pin_toggle(LCD_BACKLIGHT);
    NRF_LOG_DEBUG("tick: %d\n", tick);
    //gdispControl(GDISP_CONTROL_INVERSE, 1);
    //gfxSleepMilliseconds(1000);
    //gdispControl(GDISP_CONTROL_INVERSE, 0);
    nrf_delay_ms(30);

    // pin experiments
    /*
    nrf_gpio_cfg_input(row_pins[rowidx], NRF_GPIO_PIN_PULLUP);
    if (rowidx < (sizeof(row_pins)-1))
      rowidx++;
    else
    {
      rowidx = 0;
      NRF_LOG_INFO("\n");
    }
    */

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
      /*
      // capture port state w/ column mask
      gpio_state = nrf_gpio_port_in_read(NRF_GPIO) & colmask;
      // find bit pos of col which is low
      gpio_state = ~gpio_state & colmask;  // invert, masked
      col = bitpos(gpio_state);
      */

      // set row back to input pullup
      nrf_gpio_cfg_input(row, NRF_GPIO_PIN_PULLUP);
      // keypress found, print col & row
      if (pressed)
      {
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

    sprintf(sbuf, "batt: %3d",get_batt_level()*3);
    gdispFillString(0, 80, sbuf, font_med, White, Black);

    /*
    gpio_state = nrf_gpio_port_in_read(NRF_GPIO) & colmask;
    if (prev_state != 0)
      
      state_diff |= gpio_state ^ prev_state;
    
    sprintf(sbuf, "port state: 0x%08X", gpio_state);
    gdispFillString(0,70, sbuf, font_med, White, Black);
    NRF_LOG_INFO("port state: 0x%08X", gpio_state);

    sprintf(sbuf, "state diff: 0x%08X ", state_diff);
    gdispFillString(0,90, sbuf, font_med, White, Black);
    NRF_LOG_INFO("state diff: 0x%08X", state_diff);

    init_diff = gpio_state ^ init_state;
    NRF_LOG_INFO("init  diff: 0x%08X, b: %d", init_diff, bitpos(init_diff));

    NRF_LOG_INFO("row pin: %d\n", row_pins[rowidx]);
    */

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
