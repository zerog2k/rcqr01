#ifndef STR_HELPER
#define STR_HELPER(x) #x
#define STR(x) STR_HELPER(x)
#endif

#include STR(NRF_SDK_DIR/components/proprietary_rf/esb/nrf_esb.c)
