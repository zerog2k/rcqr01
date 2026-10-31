#ifndef RCQR_NRF_LOG_FORWARDER_H
#define RCQR_NRF_LOG_FORWARDER_H

#ifndef NRF_SDK_DIR
#error "NRF_SDK_DIR must point to an nRF5 SDK checkout"
#endif

#define RCQR_STRINGIFY_IMPL(value) #value
#define RCQR_STRINGIFY(value) RCQR_STRINGIFY_IMPL(value)

#include RCQR_STRINGIFY(NRF_SDK_DIR/components/libraries/log/nrf_log.h)

#endif // RCQR_NRF_LOG_FORWARDER_H
