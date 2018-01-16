// keypad stuff

// port mask for keypad matrix
#define KEY_MASK 0x37FE0F00

const uint8_t matrixpins[] = { 8, 9, 10, 11, 17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 28, 29 };

#define ROW_SIZE  8
#define COL_SIZE  8
const uint8_t row_pins[ROW_SIZE] = { 8, 18, 19, 20, 21, 22, 23, 24 }; // rows have external pullups
const uint32_t rowmask = BIT_8 | BIT_18 | BIT_19 | BIT_20 | BIT_21 | BIT_22 | BIT_23 | BIT_24;
const uint8_t col_pins[COL_SIZE] = { 9, 10, 11, 17, 25, 26, 28, 29 }; 
const uint32_t colmask = BIT_9 | BIT_10 | BIT_11 | BIT_17 | BIT_25 | BIT_26 | BIT_28 | BIT_29;

// keypad lookup table (cols/rows swapped here)
const char keytab[64] = {   0x65, 0x73, 0x64, 0x78, 0xf2, 0x32, 0x33, 0x77,
                            0x72, 0x66, 0x76, 0x63, 0xf3, 0xd3, 0xd1, 0x34,
                            0x61, 0x7a, 0x5e, 0x25, 0xf1, 0xc0, 0x31, 0x71,
                            0x70, 0x2b, 0x08, 0x0a, 0xf5,  0x0, 0xc1, 0x30,
                            0x68, 0x6e, 0x20,  0x0, 0xf4, 0xd2, 0x36, 0x79,
                            0x74, 0x67, 0x62,  0x0,  0x0, 0xd0, 0xd4, 0x35,
                            0x6a, 0x6d, 0x2c,  0x0,  0x0,  0x0, 0x37, 0x75,
                            0x69, 0x6b, 0x6c, 0x2e,  0x0, 0x38, 0x39, 0x6f  };


char get_key_char_from_table(uint8_t col, uint8_t row)
{
  uint8_t idx = (col * 8) + row;
  return keytab[idx];
}

void keypad_on(void)
{
  uint8_t i;
  // set cols to inputs
  for (i=0; i < sizeof(col_pins); i++)
    nrf_gpio_cfg_input(col_pins[i], NRF_GPIO_PIN_PULLUP);

  // set rows to inputs, pullups (have external pullups)
  for (i=0; i < sizeof(row_pins); i++)
    nrf_gpio_cfg_input(row_pins[i], NRF_GPIO_PIN_PULLUP);
  
  //nrf_gpio_range_cfg_output(17, 24, NRF_GPIO_PIN_NOPULL);
}

void keypad_off(void)
{
  uint8_t i;
  for (i=0; i < sizeof(col_pins); i++)
    nrf_gpio_cfg_input(col_pins[i], NRF_GPIO_PIN_NOPULL);

  for (i=0; i < sizeof(row_pins); i++)
    nrf_gpio_cfg_input(row_pins[i], NRF_GPIO_PIN_NOPULL);
}

char scan_keypad(void)
{
    uint8_t c = 0;
    uint8_t rowidx, rowpin, colidx, colpin, pressed = 0;
    keypad_on();
    // scan keypad, loop through rows
    pressed = 0;
    for (rowidx=0; rowidx < ROW_SIZE; rowidx++)
    {
      // set row to output low
      rowpin = row_pins[rowidx];
      nrf_gpio_cfg_output(rowpin);
      nrf_gpio_pin_write(rowpin, 0);
      // find col which is set low
      for (colidx=0; colidx < COL_SIZE; colidx++)
      {
        colpin = col_pins[colidx];
        if (nrf_gpio_pin_read(colpin) == 0)
        {
          pressed++;
          break;
        }
      }

      // set row back to input pullup
      nrf_gpio_cfg_input(rowpin, NRF_GPIO_PIN_PULLUP);
  
      if (pressed)
      {
        // keypress found, print col & row
        c = get_key_char_from_table(colidx, rowidx);
        NRF_LOG_INFO("colpin: %02d, rowpin: %02, col: %02d, row: %02d\n", colpin, rowpin, colidx, rowidx);
        break;
      }
    }
    keypad_off();  
    return c;
}
