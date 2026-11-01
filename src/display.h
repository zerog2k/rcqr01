#ifndef _DISPLAY_H
#define _DISPLAY_H

#include "clib/u8g2.h"

/* shared u8g2 instance for all drawing code */
extern u8g2_t u8g2;

void display_init(void);

/* forget what the ST7586 panel RAM currently holds (blank-page skip map,
   phase C1); call after anything that may cut panel power */
void display_invalidate_panel_state(void);
uint8_t display_contrast_get(void);
void display_contrast_set(uint8_t contrast);

#endif /* _DISPLAY_H */
