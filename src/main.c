// Turning Technologies RCQR-01 demo app
// Jens Jensen 2017,2026

// SDK 12.3.0 docs link: http://infocenter.nordicsemi.com/topic/com.nordic.infocenter.sdk5.v12.3.0/index.html

#include <stdbool.h>
#include <stdio.h>
#include <stdint.h>

#include "nrf.h"
#include "nrf_delay.h"
#include "nrf_gpio.h"
#include "nrf_log.h"
#include "nrf_log_ctrl.h"
#include "SEGGER_RTT.h"

#define LCD_BACKLIGHT 13

// LCD Boost converter/regulator control pins
#define MCP1256_PGOOD 14
#define MCP1256_SLEEP 15
#define MCP1256_ENABLE  27 // shutdown

#include "radio.h"
#include "apptimers.h"
//#include "rtc.h"    // experimentation w/ rtc - using app_timers instead for now
#include "display.h"
#include "adc_hal.h"
#include "keypad.h"
#include "sleep.h"
#include "eeprom.h"

#include "nrf_ic_info.h"
nrf_ic_info_t nrf_info;

#define DISPLAY_TEXT_X 1 // horizontal offset.

uint32_t elapsed, prev_draw_time = 0;

uint8_t i, c, prev_keyscan, last_press_seconds = 0;
uint8_t eepbuf[16];
uint16_t j;
uint8_t contrast = 255;

sleep_mode_t sleep_mode = MODE_ACTIVE;

/* full-screen status redraw, replacing the old set of gdispFillString calls */
static void render_status(char key, uint32_t el,
                          uint32_t secs, int16_t batt,
                          uint32_t draw_delay, uint8_t contrast)
{
  char line_char[16];
  char line_tick[48];
  char line_elapsed[48];
  char line_batt[16];
  char line_delay[48];

  /*
   * Snapshot and format all dynamic values once, before the page loop.
   * u8g2 page mode calls DrawStr() once per 8-line page; formatting inside
   * the loop re-reads tick/seconds/get_vcc() for every page.  Since a full
   * screen update takes several milliseconds, different pages of the same
   * glyph could be rendered with different values, which looks like
   * corrupted/torn digits.
   */
  sprintf(line_char,    "char: %c", key);
  sprintf(line_tick,    "hello lcd land, tick: %8lu", (unsigned long)tick);
  sprintf(line_elapsed, "elapsed: %4lu, secs: %5lu",
          (unsigned long)el, (unsigned long)secs);
  sprintf(line_batt,    "batt: %3u", (unsigned)batt);
  /* Keep this line within the measured visible display width. */
  sprintf(line_delay,   "delay: %3lu, contrast: %2u",
          (unsigned long)draw_delay, (unsigned)contrast);

  u8g2_SetFont(&u8g2, u8g2_font_10x20_tf);
  u8g2_SetFontMode(&u8g2, 1);  /* transparent: FirstPage() clears the page
                                  buffer, opaque backgrounds are pure waste */

  u8g2_ClearBuffer(&u8g2);
  u8g2_FirstPage(&u8g2);
  do {
    u8g2_DrawStr(&u8g2, DISPLAY_TEXT_X, 130, line_char);
    u8g2_DrawStr(&u8g2, DISPLAY_TEXT_X,  40, line_tick);
    u8g2_DrawStr(&u8g2, DISPLAY_TEXT_X,  60, line_elapsed);
    u8g2_DrawStr(&u8g2, DISPLAY_TEXT_X,  80, line_batt);
    u8g2_DrawStr(&u8g2, DISPLAY_TEXT_X, 110, line_delay);
  } while (u8g2_NextPage(&u8g2));
}

int main(void)
 {
  SEGGER_RTT_Init();
  SEGGER_RTT_WriteString(0, "entered main\n");
  nrf_delay_ms(10);

  // initially tristate all col/row pins
  nrf_gpio_range_cfg_input(0, 31, NRF_GPIO_PIN_NOPULL);

  // setup led/lcd regulator
  nrf_gpio_cfg_output(MCP1256_SLEEP);
  nrf_gpio_cfg_output(MCP1256_ENABLE);
  nrf_gpio_pin_write(MCP1256_SLEEP, 1);
  nrf_gpio_pin_write(MCP1256_ENABLE, 1);  // SHUTDOWN pin, active low
  //nrf_gpio_cfg_output(LCD_BACKLIGHT);
  //nrf_gpio_pin_write(LCD_BACKLIGHT, 1);

  NRF_LOG_INIT(NULL);
  NRF_LOG_INFO("startup: log initialized\n");
  apptimers_init();
  NRF_LOG_INFO("startup: timers initialized\n");
  //rtc_init();

  // Setup display
  display_init();
  NRF_LOG_INFO("startup: graphics initialized\n");

  // Draw the boot info screen (u8g2 page loop, see below).
  char line_rfch[96];
  char line_did[96];
  nrf_ic_info_get(&nrf_info);
  sprintf(line_rfch, "RFCH:%02d, icrev: %d, flsz: %d, ramsz: %d",
          get_channel(), nrf_info.ic_revision, nrf_info.flash_size, nrf_info.ram_size);
  sprintf(line_did, "did1: 0x%lx, did0: 0x%lx, rb: %lu",
          (unsigned long)NRF_FICR->DEVICEID[1],
          (unsigned long)NRF_FICR->DEVICEID[0],
          (unsigned long)NRF_FICR->NUMRAMBLOCK);

  u8g2_FirstPage(&u8g2);
  do {
    u8g2_SetFont(&u8g2, u8g2_font_7x13_tf);
    u8g2_SetFontMode(&u8g2, 1);   // transparent glyphs (buffer cleared per page)
    u8g2_DrawStr(&u8g2, DISPLAY_TEXT_X, 10, line_rfch);
    u8g2_DrawStr(&u8g2, DISPLAY_TEXT_X, 30, line_did);

    u8g2_SetFont(&u8g2, u8g2_font_10x20_tf);
    u8g2_DrawStr(&u8g2, DISPLAY_TEXT_X, 60, "Hello lcd");

    // some test graphics...
    //u8g2_DrawDisc(&u8g2, 80, 80, 10, U8G2_DRAW_ALL);
    //u8g2_DrawBox(&u8g2, 0, 0, 10, 10);
    //u8g2_DrawBox(&u8g2, 330, 0, 10, 10);
    //u8g2_DrawBox(&u8g2, 0, 140, 20, 20);
  } while (u8g2_NextPage(&u8g2));
  NRF_LOG_INFO("startup: display drawn\n");
                                                                                                     
  radio_init();
  NRF_LOG_INFO("startup: radio initialized\n");
  adc_init();
  NRF_LOG_INFO("startup: adc initialized\n");


   // EEPROM
  eeprom_init();
  NRF_LOG_INFO("startup: eeprom initialized\n");

  eeprom_write_enable();
  nrf_delay_ms(5);

  /*
  // test write:
  eepbuf[0] = 0xab;
  eepbuf[1] = 0xcd;
  eepbuf[2] = 0xef;

  eeprom_write(0, 3, eepbuf); // write eepbuf
  memset(eepbuf, 0, 3); // clear eepbuf
  nrf_delay_ms(5);
  */
  //eeprom_write_sr( 1<<IPL );
  c = eeprom_read_sr();
  NRF_LOG_DEBUG("eep_sr: %02x\n", c);
  for (j=0; j<512; j+=16)
  {
    //eeprom_write_enable();
    //eeprom_write_sr( 1 << IPL );
    nrf_delay_ms(5);
    c = eeprom_read_sr();
    NRF_LOG_DEBUG("eep_sr: %02x\n", c);       
    eeprom_read(j, 16, eepbuf);
    
    //NRF_LOG_INFO("j: %02x, eepbuf: %02x %02x %02x %02x\n", j, eepbuf[0], eepbuf[1], eepbuf[2], eepbuf[3]);
    
  }

  NRF_LOG_INFO("startup: eeprom scan complete\n");
  contrast = display_contrast_get();
  NRF_LOG_INFO("startup: entering main loop\n");
  /// LOOP
  while (true)
  {
    // only run loop every 100 ms
    if (tick % 100 == 0)
    {
      NRF_LOG_DEBUG("tick: %d\n", tick);
      // playing with screen pixel inversion
      //gdispControl(GDISP_CONTROL_INVERSE, 1);
      //nrf_delay_ms(500);
      //gdispControl(GDISP_CONTROL_INVERSE, 0);
  
      if (sleep_mode == MODE_WAKEUP)
      {
        sleep_timer = seconds;    // reset sleep timer
        nrf_gpio_pin_write(MCP1256_ENABLE, 1);  // turn on lcd/led regulator
        // panel power was cut: controller RAM undefined, force full repaints
        display_invalidate_panel_state();
        //nrf_gpio_pin_write(LCD_BACKLIGHT, 1);
        low_power_pwm_duty_set(&display_pwm, DISPLAY_MEDIUM);
        sleep_mode = MODE_ACTIVE;
        continue;
      }

      if (sleep_mode == MODE_ACTIVE &&
            (seconds - sleep_timer) > SLEEP_BACKLIGHT_DELAY)
      {
        // transition from ACTIVE to backlight off
        //nrf_gpio_pin_write(LCD_BACKLIGHT, 0);  // turn off lcd/led regulator
        low_power_pwm_duty_set(&display_pwm, DISPLAY_OFF);
        sleep_mode = MODE_SLEEP_BACKLIGHT;
      }

      if (sleep_mode == MODE_SLEEP_BACKLIGHT &&
            (seconds - sleep_timer) > SLEEP_DISPLAY_DELAY)
      {
        // transition from backlight to display off & sleep
        nrf_gpio_pin_write(MCP1256_ENABLE, 0);  // turn off lcd/led regulator
        // conservative: panel loses power, nothing known blank anymore
        display_invalidate_panel_state();
        sleep_mode = MODE_SLEEP_DISPLAY;
        __WFE();
        __SEV();
        __WFE();
      }

      c = scan_keypad();
      if (c)
      {
        if (sleep_mode == MODE_ACTIVE)
        {
            sleep_timer = seconds;    // reset sleep timer
            elapsed = tick;
            // send char over radio
            send_char(c);
            // testing some power modes:
            switch (c) {
               case '+':
                low_power_pwm_duty_set(&display_pwm, DISPLAY_BRIGHT);
                break;
               case 0x08:
                // backspace
                low_power_pwm_duty_set(&display_pwm, DISPLAY_DIM);
                break;
               case 's':
                // shutdown regulator to turn off lcd & led
                nrf_gpio_pin_toggle(MCP1256_ENABLE);
                // either direction: panel power is lost/gained, invalidate
                display_invalidate_panel_state();
                break;
               case 0xd1:
                // left arrow, lower contrast
                display_contrast_set(display_contrast_get() - 2);
                contrast = display_contrast_get();
                break;
               case 0xd2:
                // right arrow, raise contrast
                display_contrast_set(display_contrast_get() + 2);
                contrast = display_contrast_get();
                break;
            }

            elapsed = tick - elapsed;

            /* show the duration of the previous redraw, not the absolute tick */
            uint32_t last_draw_time = prev_draw_time;
            int16_t vcc = get_vcc();
            prev_draw_time = tick;
            render_status(c, elapsed, seconds, vcc, last_draw_time, contrast);
            prev_draw_time = tick - prev_draw_time;

        } 
        else if (sleep_mode < MODE_WAKEUP)
        {
            sleep_mode = MODE_WAKEUP;
        }
      }
   }
  // sleep - end of loop
  __WFE();
  __SEV();
  __WFE();
  }
}

/**
 *@}
 **/
