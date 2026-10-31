/* Wrapper include for SDK app_util_platform.c */
#ifndef STR_HELPER
#define STR_HELPER(x) #x
#define STR(x) STR_HELPER(x)
#endif

#include STR(NRF_SDK_DIR/components/libraries/util/app_util_platform.c)
