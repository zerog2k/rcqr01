#include "nrf_adc.h"

#define V_BG_MV         1200    // V_bandgap: 1.2V
#define ADC_MAX_10BIT   1024

void adc_init(void)
{
  nrf_adc_config_t config = NRF_ADC_CONFIG_DEFAULT;           // adc 10-bit, vref: V_bandgap
  config.scaling = NRF_ADC_CONFIG_SCALING_SUPPLY_ONE_THIRD;   // adc input: 1/3 vcc
  nrf_adc_configure(&config);
  nrf_adc_enable();
}

int32_t get_adc_val(void)
{
    int32_t conversion = -1;
    while (nrf_adc_is_busy());
    conversion = nrf_adc_convert_single(NRF_ADC_CONFIG_INPUT_DISABLED);
    return conversion;
}

int16_t get_vcc(void)
{
  // returns vcc in mV 
  int32_t vcc = 0;
  // adc val represents 1/3 vcc ratio to V_bandgap of 1200mV
  vcc = (get_adc_val() * 3 * V_BG_MV) / ADC_MAX_10BIT;
  return vcc;
}