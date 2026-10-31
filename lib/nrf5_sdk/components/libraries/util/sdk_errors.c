/* Wrapper include for SDK sdk_errors.c */
#ifndef STR_HELPER
#define STR_HELPER(x) #x
#define STR(x) STR_HELPER(x)
#endif

#include STR(NRF_SDK_DIR/components/libraries/util/sdk_errors.c)
