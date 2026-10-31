// Wrapper to force compilation of selected nRF5 SDK C sources copied into lib/nrf5_sdk

#include "../lib/nrf5_sdk/components/libraries/timer/app_timer.c"
#include "../lib/nrf5_sdk/components/libraries/util/app_error.c"
#include "../lib/nrf5_sdk/components/libraries/util/app_error_weak.c"
#include "../lib/nrf5_sdk/components/libraries/low_power_pwm/low_power_pwm.c"
#include "../lib/nrf5_sdk/components/libraries/ic_info/nrf_ic_info.c"
#include "../lib/nrf5_sdk/components/drivers_nrf/spi_master/nrf_drv_spi.c"
#include "../lib/nrf5_sdk/components/drivers_nrf/common/nrf_drv_common.c"
#include "../lib/nrf5_sdk/components/drivers_nrf/clock/nrf_drv_clock.c"
#include "../lib/nrf5_sdk/components/libraries/log/src/nrf_log_frontend.c"
#include "../nRF5_SDK_12.3.0_d7731ad/external/segger_rtt/SEGGER_RTT.c"
// Added by agent: include additional SDK sources needed for linking
#include "../lib/nrf5_sdk/components/proprietary_rf/esb/nrf_esb.c"
#include "../lib/nrf5_sdk/components/drivers_nrf/hal/nrf_adc.c"
#include "../lib/nrf5_sdk/components/libraries/util/app_util_platform.c"
#include "../lib/nrf5_sdk/components/libraries/util/sdk_errors.c"
#include "../lib/nrf5_sdk/components/libraries/log/src/nrf_log_backend_serial.c"
