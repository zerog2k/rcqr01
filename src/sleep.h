
// display/sleep mode stuff
#define SLEEP_BACKLIGHT_DELAY    6
#define SLEEP_DISPLAY_DELAY      12

uint32_t sleep_timer = 0;

typedef enum {
  MODE_SLEEP_BACKLIGHT,
  MODE_SLEEP_DISPLAY,
  MODE_WAKEUP,
  MODE_ACTIVE
} sleep_modes_t;

typedef uint8_t sleep_mode_t;
