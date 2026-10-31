// Force compilation of the selected nRF5 SDK sources required by the app.

#ifndef NRF_SDK_DIR
#error "NRF_SDK_DIR must point to an nRF5 SDK checkout"
#endif

#define RCQR_STRINGIFY_IMPL(value) #value
#define RCQR_STRINGIFY(value) RCQR_STRINGIFY_IMPL(value)

#include RCQR_STRINGIFY(NRF_SDK_DIR/components/libraries/timer/app_timer.c)
#include RCQR_STRINGIFY(NRF_SDK_DIR/components/libraries/util/app_error.c)
#include RCQR_STRINGIFY(NRF_SDK_DIR/components/libraries/util/app_error_weak.c)
#include RCQR_STRINGIFY(NRF_SDK_DIR/components/libraries/low_power_pwm/low_power_pwm.c)
#include RCQR_STRINGIFY(NRF_SDK_DIR/components/libraries/ic_info/nrf_ic_info.c)
#include RCQR_STRINGIFY(NRF_SDK_DIR/components/drivers_nrf/spi_master/nrf_drv_spi.c)
#include RCQR_STRINGIFY(NRF_SDK_DIR/components/drivers_nrf/common/nrf_drv_common.c)
#include RCQR_STRINGIFY(NRF_SDK_DIR/components/drivers_nrf/clock/nrf_drv_clock.c)
#include RCQR_STRINGIFY(NRF_SDK_DIR/components/libraries/log/src/nrf_log_frontend.c)
#include RCQR_STRINGIFY(NRF_SDK_DIR/external/segger_rtt/SEGGER_RTT.c)
#include RCQR_STRINGIFY(NRF_SDK_DIR/components/proprietary_rf/esb/nrf_esb.c)
#include RCQR_STRINGIFY(NRF_SDK_DIR/components/drivers_nrf/hal/nrf_adc.c)
#include RCQR_STRINGIFY(NRF_SDK_DIR/components/libraries/util/app_util_platform.c)
#include RCQR_STRINGIFY(NRF_SDK_DIR/components/libraries/util/sdk_errors.c)
#include RCQR_STRINGIFY(NRF_SDK_DIR/components/libraries/log/src/nrf_log_backend_serial.c)
