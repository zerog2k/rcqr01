#ifndef _U8X8_D_ST7586_RCQR01_H
#define _U8X8_D_ST7586_RCQR01_H

#include "clib/u8g2.h"

/* custom ST7586 display driver for the RCQR-01 340x160 panel */
uint8_t u8x8_d_st7586_rcqr01(u8x8_t *u8x8, uint8_t msg, uint8_t arg_int, void *arg_ptr);

/* reset the blank-page skip map to "nothing known blank" so the next frame
   writes every page; call whenever the panel may have lost power */
void u8x8_d_st7586_rcqr01_invalidate_blank_map(void);

#endif /* _U8X8_D_ST7586_RCQR01_H */
