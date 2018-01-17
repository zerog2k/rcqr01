/*
  note: you may need to modify app_timer.c to use SWI3 instead of SWI0, which is already used by nrf_esb.c
  >> #define SWI_IRQn SWI3_IRQn
  >> #define SWI_IRQHandler SWI3_IRQHandler
*/

#include "app_timer.h"
#include "nrf_drv_clock.h"

#define APP_TIMER_PRESCALER            0                     /**< Value of the RTC1 PRESCALER register. */
//#define APP_TIMER_MAX_TIMERS            4                     /**< Maximum number of simultaneously created timers. */
#define TIMER_TICKS		        APP_TIMER_TICKS(1, APP_TIMER_PRESCALER)
#define SECONDS_TICKS                   APP_TIMER_TICKS(1000, APP_TIMER_PRESCALER)

//For the queue size I used what was used for the example I copy/pasted.  There
//is an explanation on the Nordic Devzone on the APP_TIMER_OP_QUEUE_SIZE
//https://devzone.nordicsemi.com/question/723/how-big-should-app_timer_op_queue_size-be/
#define APP_TIMER_OP_QUEUE_SIZE         4                     /**< Size of timer operation queues. */
   /**< identifies this timer in the timer queue (only one in queue so...) */
/**@brief Function for starting application timers.
 */

static uint32_t tick = 0;
static uint32_t seconds = 0;

static void tick_handler(void * p_context)
{
  UNUSED_PARAMETER(p_context);
  tick++;
}

static void seconds_handler(void * p_context)
{
  UNUSED_PARAMETER(p_context);
  seconds++;
}


/** @brief Function starting the internal LFCLK XTAL oscillator.
 */
static void lfclk_config(void)
{
    ret_code_t err_code = nrf_drv_clock_init();
    APP_ERROR_CHECK(err_code);
    nrf_drv_clock_lfclk_request(NULL);
}

/**@brief Function for the Timer initialization.
 *
 * @details Initializes the timer module. This creates and starts application timers.
 */
static void apptimers_init(void)
{
  //initialize the low frequency clock

  // Initialize timer module.
  APP_TIMER_INIT(APP_TIMER_PRESCALER, APP_TIMER_OP_QUEUE_SIZE, NULL);

  lfclk_config();

  // Create timers.
  uint32_t err_code;
  APP_TIMER_DEF( m_timer_id );
  err_code = app_timer_create(&m_timer_id,
			      APP_TIMER_MODE_REPEATED,
			      tick_handler);
  APP_ERROR_CHECK(err_code);

  APP_TIMER_DEF( m_secondsticker_id );
  err_code = app_timer_create(&m_secondsticker_id,
			      APP_TIMER_MODE_REPEATED,
			      seconds_handler);
  APP_ERROR_CHECK(err_code);

  // Start application timers.
  err_code = app_timer_start(m_timer_id, TIMER_TICKS, NULL);
  APP_ERROR_CHECK(err_code);
  err_code = app_timer_start(m_secondsticker_id, SECONDS_TICKS, NULL);
  APP_ERROR_CHECK(err_code);

}


