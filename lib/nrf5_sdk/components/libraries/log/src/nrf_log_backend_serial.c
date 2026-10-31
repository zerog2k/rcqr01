/* Wrapper include for SDK nrf_log_backend_serial.c */
#ifndef STR_HELPER
#define STR_HELPER(x) #x
#define STR(x) STR_HELPER(x)
#endif

#include STR(NRF_SDK_DIR/components/libraries/log/src/nrf_log_backend_serial.c)
