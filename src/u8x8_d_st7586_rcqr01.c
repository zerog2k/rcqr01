/*
 * u8x8_d_st7586_rcqr01.c
 *
 * Custom u8x8 display driver for the RCQR-01 (Turning Technologies QT clicker)
 * ST7586 panel: 340x160 pixels, 2-bit grayscale packing (3 pixels per byte).
 *
 * Adapted from:
 *   - the original working uGFX ST7586 driver (drivers/gdisp/ST7586), and
 *   - u8g2's u8x8_d_st7586s_jlx320160.c (same pixel packing, m_42_20 memory).
 *
 * Geometry (from the original uGFX driver):
 *   - visible area: 340 x 160; the leftmost 21 controller columns (63 px)
 *     are hidden, data starts at controller column 21/3 = 7
 *   - column window: 7..126 (120 triple-columns = 340 pixels)
 *   - row window: 0..159
 */

#include "u8x8_d_st7586_rcqr01.h"

/* controller column (triple-pixel-unit) where the visible area starts */
#define ST7586_RCQR01_DISPLAY_COL_OFFSET   7
/* number of visible triple-columns: 320 / 3 */
#define ST7586_RCQR01_DISPLAY_COLS         120

/* staging buffer for one page of expanded ST7586 data:
   the u8g2 page buffer delivers 8 rows x 45 bytes, which expand to
   8 rows x 120 triple-columns = 960 controller bytes; sent in chunks of
   at most 255 bytes because u8x8_cad_SendData() and
   nrf_drv_spi_transfer() both take a uint8_t count */
#define ST7586_RCQR01_PAGE_OUT_MAX  (ST7586_RCQR01_DISPLAY_COLS * 8)
#define ST7586_RCQR01_SEND_CHUNK    255

static uint8_t page_out[ST7586_RCQR01_PAGE_OUT_MAX];

/* number of 8-row pages (tile rows): 160 / 8 */
#define ST7586_RCQR01_DISPLAY_PAGES  20

/* blank-page skip map (phase C1): one bit per page; a set bit means the page
   was blank in the last frame actually sent, so the panel keeps its RAM and
   the page can be skipped entirely. All bits start 0 = "not known blank",
   so the first frame after power-up/init writes every page: 20 pages -> 3 B */
static uint8_t blank_pages[(ST7586_RCQR01_DISPLAY_PAGES + 7) / 8];

static const uint8_t u8x8_d_st7586_rcqr01_sleep_on[] = {
  U8X8_START_TRANSFER(),              /* enable chip */
  U8X8_C(0x010),                      /* display off / power save */
  U8X8_END_TRANSFER(),                /* disable chip */
  U8X8_END()
};

static const uint8_t u8x8_d_st7586_rcqr01_sleep_off[] = {
  U8X8_START_TRANSFER(),
  U8X8_C(0x011),                      /* sleep out */
  U8X8_DLY(50),
  U8X8_END_TRANSFER(),
  U8X8_END()
};

static const uint8_t u8x8_d_st7586_rcqr01_init_seq[] = {
  U8X8_START_TRANSFER(),

  U8X8_C(0x001),                      /* soft reset */
  U8X8_DLY(60),

  U8X8_CA(0x0d7, 0x09f),              /* auto read control: disable */
  U8X8_CA(0x0e0, 0x000),              /* enable OTP read */
  U8X8_DLY(50),
  U8X8_C(0x0e3),                      /* OTP upload procedure */
  U8X8_DLY(50),
  U8X8_C(0x0e1),                      /* OTP control out */

  U8X8_C(0x011),                      /* sleep out */
  U8X8_C(0x028),                      /* display off */
  U8X8_DLY(50),

  U8X8_CAA(0x0c0, 0x000, 0x001),      /* VOP = 100h (contrast) */
  U8X8_CA(0x0c3, 0x005),              /* bias system: 1/9 */
  U8X8_CA(0x0c4, 0x007),              /* booster level: 8x */
  U8X8_CA(0x0b5, 0x08d),              /* n-line inversion */
  U8X8_C(0x038),                      /* gray display mode */
  U8X8_CA(0x03a, 0x002),              /* enable DDRAM interface, 4-level */
  U8X8_CA(0x036, 0x0c8),              /* scan direction: MY=1, MX=1 */
  U8X8_CA(0x0b0, 0x09f),              /* display duty cycle: 160 - 1 */
  U8X8_C(0x020),                      /* display inversion off */
  U8X8_CAAAA(0x02a, 0x000, ST7586_RCQR01_DISPLAY_COL_OFFSET, 0x000,
             ST7586_RCQR01_DISPLAY_COL_OFFSET + ST7586_RCQR01_DISPLAY_COLS - 1),
                                      /* column address: XS, XE */
  U8X8_CAAAA(0x02b, 0x000, 0x000, 0x000, 0x09f),
                                      /* row address: YS, YE = 159 */
  U8X8_CA(0x0b1, 0x000),              /* first output COM: 0 */
  U8X8_CAAAA(0x0f1, 0x015, 0x015, 0x015, 0x015),
                                      /* frame rate, mono mode, 92Hz */
  U8X8_CA(0x025, 0x0c3),              /* undocumented, from original driver */

  U8X8_C(0x029),                      /* display on */
  U8X8_END_TRANSFER(),                /* disable chip */
  U8X8_END()                          /* end of sequence */
};

static const uint8_t u8x8_d_st7586_rcqr01_flip0_seq[] = {
  U8X8_START_TRANSFER(),
  U8X8_C(0x036),                      /* scan direction */
  U8X8_A(0x0c8),                      /* MY = 1, MX = 1 */
  U8X8_END_TRANSFER(),
  U8X8_END()
};

/* Flip mode not really supported: use u8g2 rotation instead */
static const uint8_t u8x8_d_st7586_rcqr01_flip1_seq[] = {
  U8X8_START_TRANSFER(),
  U8X8_C(0x036),                      /* scan direction */
  U8X8_A(0x000),                      /* MY = 0, MX = 0 */
  U8X8_END_TRANSFER(),
  U8X8_END()
};

static const u8x8_display_info_t u8x8_st7586_rcqr01_display_info = {
  /* chip_enable_level = */ 0,
  /* chip_disable_level = */ 1,

  /* post_chip_enable_wait_ns = */ 5,
  /* pre_chip_disable_wait_ns = */ 5,

  /* reset_pulse_width_ms = */ 20,    /* original board used a 20 ms pulse */
  /* post_reset_wait_ms = */ 20,

  /* sda_setup_time_ns = */ 20,
  /* sck_pulse_width_ns = */ 100,     /* ST7586S datasheet */
  /* sck_clock_hz = */ 8000000UL,     /* SPI bus speed, matches board config */

  /* spi_mode = */ 3,                 /* active high, rising edge */
  /* i2c_bus_clock_100kHz = */ 4,

  /* data_setup_time_ns = */ 20,
  /* write_pulse_width_ns = */ 40,

  /* tile_width = */ 45,              /* 45 * 8 = 360 pixels */
  /* tile_height = */ 20,             /* 20 * 8 = 160 pixels */

  /* default_x_offset = */ 0,
  /* flipmode_x_offset = */ 0,

  /* pixel_width = */ 360,
  /* pixel_height = */ 160
};

static uint8_t _blank_page_get(uint8_t idx)
{
  return (blank_pages[idx >> 3] >> (idx & 7)) & 1;
}

static void _blank_page_set(uint8_t idx, uint8_t val)
{
  if (val)
    blank_pages[idx >> 3] |= 1u << (idx & 7);
  else
    blank_pages[idx >> 3] &= (uint8_t)~(1u << (idx & 7));
}

/* phase C1 invalidation: forget what the panel RAM currently looks like,
   so the next frame writes every page. Call after panel power loss
   (sleep/wake, 's' toggle, power-save, init/reset). */
void u8x8_d_st7586_rcqr01_invalidate_blank_map(void)
{
  uint8_t i;
  for (i = 0; i < sizeof(blank_pages); i++)
    blank_pages[i] = 0;
}

uint8_t u8x8_d_st7586_rcqr01(u8x8_t *u8x8, uint8_t msg, uint8_t arg_int, void *arg_ptr)
{
  uint16_t c, out_len, off, tile_cnt;
  uint8_t *ptr;
  uint32_t input;
  uint8_t i, byte, n;
  uint8_t *out;
  uint8_t *tile_ptr, tile_blank, page;

  switch (msg) {
    case U8X8_MSG_DISPLAY_DRAW_TILE:

    /* phase C1: an all-zero tile row contains no pixels. The panel retains
       its RAM, so if this page was also blank in the last frame actually
       sent, skip it completely (no CS, no commands, no data). A newly blank
       page is still sent once to clear the old content, then its map bit
       is set. The map must always reflect the last frame actually sent. */
    tile_cnt = ((u8x8_tile_t *)arg_ptr)->cnt;
    tile_cnt *= 8;                       /* normally 45 * 8 = 360 bytes */
    tile_ptr = ((u8x8_tile_t *)arg_ptr)->tile_ptr;
    tile_blank = 1;
    while (tile_cnt > 0)
    {
      if (*tile_ptr++ != 0)
      {
        tile_blank = 0;
        break;
      }
      tile_cnt--;
    }
    page = ((u8x8_tile_t *)arg_ptr)->y_pos;
    if (page < ST7586_RCQR01_DISPLAY_PAGES)
    {
      if (tile_blank && _blank_page_get(page))
        return 1;                        /* already blank on the panel */
      _blank_page_set(page, tile_blank);
    }

    u8x8_cad_StartTransfer(u8x8);

    /* row address window: page start row .. last row */
    u8x8_cad_SendCmd(u8x8, 0x02b);  /* row address setting */
    u8x8_cad_SendArg(u8x8, 0x000);
    u8x8_cad_SendArg(u8x8, 0x008 * ((u8x8_tile_t *)arg_ptr)->y_pos);
    u8x8_cad_SendArg(u8x8, 0x000);
    u8x8_cad_SendArg(u8x8, u8x8->display_info->pixel_height - 1);

    /* column address window: the 120 visible triple-columns */
    u8x8_cad_SendCmd(u8x8, 0x02a);  /* column address setting */
    u8x8_cad_SendArg(u8x8, 0x000);
    u8x8_cad_SendArg(u8x8, ST7586_RCQR01_DISPLAY_COL_OFFSET);
    u8x8_cad_SendArg(u8x8, 0x000);
    u8x8_cad_SendArg(u8x8, ST7586_RCQR01_DISPLAY_COL_OFFSET
                           + ST7586_RCQR01_DISPLAY_COLS - 1);

    u8x8_cad_SendCmd(u8x8, 0x02c);  /* write display data to RAM */

    c = ((u8x8_tile_t *)arg_ptr)->cnt;
    c *= 8;
    ptr = ((u8x8_tile_t *)arg_ptr)->tile_ptr;

    /* expand u8g2's horizontal-LSb bytes into 2-bit-per-pixel ST7586 data:
       every 3 input bytes (24 pixels) become 8 output bytes, staged into
       page_out so the whole row can be sent in few large transfers */
    out = page_out;
    while (c > 0)
    {
      input = (((uint32_t)ptr[0] << 16) | ((uint32_t)ptr[1] << 8) | (uint32_t)ptr[2]);
      for (i = 0; i < 8; i++)
      {
        byte = 0;
        if (input & 0x800000)       /* if bit 23 */
          byte |= 0xc0;             /* set pixel 1 */
        if (input & 0x400000)       /* if bit 22 */
          byte |= 0x18;             /* set pixel 2 */
        if (input & 0x200000)       /* if bit 21 */
          byte |= 0x03;             /* set pixel 3 */
        *out++ = byte;
        input <<= 3;
      }
      ptr += 3;
      c -= 3;
    }
    out_len = (uint16_t)(out - page_out);

    /* send the expanded row as big chunks; u8x8_cad_011's SEND_DATA
       forwards the full count in one byte-callback call, and the SPI
       transfer length is uint8_t so chunks must stay <= 255 bytes */
    for (off = 0; off < out_len; off += ST7586_RCQR01_SEND_CHUNK)
    {
      n = (out_len - off > ST7586_RCQR01_SEND_CHUNK)
            ? ST7586_RCQR01_SEND_CHUNK : (uint8_t)(out_len - off);
      u8x8_cad_SendData(u8x8, n, page_out + off);
    }
    u8x8_cad_EndTransfer(u8x8);
    break;

    case U8X8_MSG_DISPLAY_INIT:
      u8x8_d_helper_display_init(u8x8);
      u8x8_cad_SendSequence(u8x8, u8x8_d_st7586_rcqr01_init_seq);
      break;

    case U8X8_MSG_DISPLAY_SETUP_MEMORY:
      u8x8_d_helper_display_setup_memory(u8x8, &u8x8_st7586_rcqr01_display_info);
      break;

    case U8X8_MSG_DISPLAY_SET_FLIP_MODE:
      if (arg_int == 0)
      {
        u8x8_cad_SendSequence(u8x8, u8x8_d_st7586_rcqr01_flip0_seq);
        u8x8->x_offset = u8x8->display_info->default_x_offset;
      }
      else
      {
        u8x8_cad_SendSequence(u8x8, u8x8_d_st7586_rcqr01_flip1_seq);
        u8x8->x_offset = u8x8->display_info->flipmode_x_offset;
      }
      break;

    case U8X8_MSG_DISPLAY_SET_POWER_SAVE:
      /* conservative: a power-save cycle or panel power-down leaves the
         controller RAM contents outside the driver's knowledge */
      u8x8_d_st7586_rcqr01_invalidate_blank_map();
      if (arg_int == 0)
        u8x8_cad_SendSequence(u8x8, u8x8_d_st7586_rcqr01_sleep_off);
      else
        u8x8_cad_SendSequence(u8x8, u8x8_d_st7586_rcqr01_sleep_on);
      break;

#ifdef U8X8_WITH_SET_CONTRAST
    case U8X8_MSG_DISPLAY_SET_CONTRAST:
      u8x8_cad_StartTransfer(u8x8);
      u8x8_cad_SendCmd(u8x8, 0x0c0);  /* VOP */
      u8x8_cad_SendArg(u8x8, arg_int);
      u8x8_cad_SendArg(u8x8, 1);
      u8x8_cad_EndTransfer(u8x8);
      break;
#endif

    default:
      return 0;
  }
  return 1;
}
