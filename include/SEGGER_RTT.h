#ifndef RCQR_SEGGER_RTT_WRAPPER_H
#define RCQR_SEGGER_RTT_WRAPPER_H

#ifndef NRF_SDK_DIR
#error "NRF_SDK_DIR must point to an nRF5 SDK checkout"
#endif

#define RCQR_STRINGIFY_IMPL(value) #value
#define RCQR_STRINGIFY(value) RCQR_STRINGIFY_IMPL(value)

#include RCQR_STRINGIFY(NRF_SDK_DIR/external/segger_rtt/SEGGER_RTT.h)

#endif // RCQR_SEGGER_RTT_WRAPPER_H
