#include "display.h"
#include "u8g2_nrf51.h"
#include "u8x8_d_st7586_rcqr01.h"
#include "board_ST7586.h"

u8g2_t u8g2;

/* one-page buffer: 45 tiles (360 px) x 8 lines = 360 bytes,
   ~6.8 KB less RAM than a full framebuffer */
static uint8_t u8g2_page_buffer[45 * 8];

void display_init(void) {
    // configure pins/reset and the HW SPI instance
    st7586_board_init();

    // custom ST7586 (RCQR-01) display driver, 340x160, packed 2-bit pixels
    u8g2_SetupDisplay(
        &u8g2,
        u8x8_d_st7586_rcqr01,
        u8x8_cad_011,
        u8x8_byte_nrf51_hw_spi,
        u8x8_gpio_and_delay_nrf51
    );
    u8g2_SetupBuffer(
        &u8g2,
        u8g2_page_buffer,
        1, /* one tile row = 8-line page buffer */
        u8g2_ll_hvline_horizontal_right_lsb,
        U8G2_R0
    );

    // assign physical pin mappings matching board config
    u8x8_SetPin(u8g2_GetU8x8(&u8g2), U8X8_PIN_CS, LCD_CS);
    u8x8_SetPin(u8g2_GetU8x8(&u8g2), U8X8_PIN_DC, LCD_DC);
    u8x8_SetPin(u8g2_GetU8x8(&u8g2), U8X8_PIN_RESET, LCD_RST);

    u8g2_InitDisplay(&u8g2);
    u8g2_SetPowerSave(&u8g2, 0);
}

/* ST7586 contrast is stepped via VOP joystick commands, as in the
   original uGFX driver. 0..100 is the usable range. */
static uint8_t display_contrast = 51;   /* initial value, as in the old driver */

uint8_t display_contrast_get(void)
{
    return display_contrast;
}

void display_contrast_set(uint8_t contrast)
{
    u8x8_t *u8x8 = u8g2_GetU8x8(&u8g2);

    if (contrast > 100)
        contrast = 100;
    if (contrast == display_contrast)
        return;

    u8x8_cad_StartTransfer(u8x8);
    while (display_contrast != contrast)
    {
        if (contrast > display_contrast)
        {
            u8x8_cad_SendCmd(u8x8, 0x0c1);   /* VOP increment */
            display_contrast++;
        }
        else
        {
            u8x8_cad_SendCmd(u8x8, 0x0c2);   /* VOP decrement */
            display_contrast--;
        }
    }
    u8x8_cad_EndTransfer(u8x8);
}
