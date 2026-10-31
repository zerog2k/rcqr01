/* Wrapper include for SDK ADC HAL */
#ifndef STR_HELPER
#define STR_HELPER(x) #x
#define STR(x) STR_HELPER(x)
#endif

#include STR(NRF_SDK_DIR/components/drivers_nrf/hal/nrf_adc.c)
