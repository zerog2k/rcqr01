#ifndef _DISPLAY_H
#define _DISPLAY_H

#include "clib/u8g2.h"

/* shared u8g2 instance for all drawing code */
extern u8g2_t u8g2;

/* 360x160 display geometry */
#define DISPLAY_WIDTH   360
#define DISPLAY_HEIGHT  160

void display_init(void);
uint8_t display_contrast_get(void);
void display_contrast_set(uint8_t contrast);

#endif /* _DISPLAY_H */
