#include "sleep_manager.h"

// NOTE: the recommended source of sleep code is from the Artemis OpenLog
// https://github.com/sparkfun/OpenLog_Artemis/blob/69682123ea2ae3ceb3983a7d8260eaef6259a0e2/Firmware/OpenLog_Artemis/lowerPower.ino

//--------------------------------------------------------------------------------

void sleep_for_seconds(long number_of_seconds, int nbr_blinks){
  Serial.print(F("sleep for "));
  Serial.print(number_of_seconds);
  Serial.println(F(" seconds"));

  prepare_to_sleep();
  unsigned long int millis_lost {0};
  unsigned long int last_millis {0};

  for (long i=0; i<number_of_seconds; i++){
    am_hal_sysctrl_sleep(AM_HAL_SYSCTRL_SLEEP_DEEP);
    wdt.restart();

    #if (PERFORM_SLEEP_BLINK == 1)
      last_millis = millis();
      if (i % interval_between_sleep_LED_blink_seconds == 0){
        for (int j=0; j<nbr_blinks; j++){
          pinMode(LED, OUTPUT);
          digitalWrite(LED, HIGH);
          delay(duration_sleep_LED_blink_milliseconds);
          digitalWrite(LED, LOW);
          delay(duration_sleep_LED_blink_milliseconds);
        }
      }
      millis_lost += millis() - last_millis;
      if (millis_lost > 1000UL){
        i++;
        millis_lost -= 1000UL;
      }
    #endif
  }

  wake_up();
}

void sleep_until_posix(time_t posix_timestamp){
  Serial.print(F("sleep until posix "));
  Serial.println((long)posix_timestamp);

  prepare_to_sleep();

  if (board_time_manager.posix_timestamp_is_valid()){
    while (board_time_manager.get_posix_timestamp() < posix_timestamp){
      am_hal_sysctrl_sleep(AM_HAL_SYSCTRL_SLEEP_DEEP);
      wdt.restart();
    }
  }
  else{
    Serial.println(F("no valid posix timestamp, cannot sleep to posix; sleep for default 1 hour"));
    for (long i=0; i<3600; i++){
      am_hal_sysctrl_sleep(AM_HAL_SYSCTRL_SLEEP_DEEP);
      wdt.restart();
    }
  }

  wake_up();
}

//--------------------------------------------------------------------------------
void prepare_to_sleep(void){
  turn_gnss_off();
  turn_iridium_off();

  digitalWrite(busVoltageMonEN, LOW);
  digitalWrite(LED, LOW);

  turn_qwiic_switch_off();
  turn_thermistors_off();
  delay(50);

  Serial.println(F("power down Wire"));
  Wire.end();
  wdt.restart();
  delay(100);

  Serial.println(F("power down board"));
  Serial.println(F("------ SLEEP ------"));
  delay(100);
  Serial.flush();
  Serial.end();
  delay(50);

#if 0
  // Disable ADC
  powerControlADC(false);

  // Force the peripherals off
  am_hal_pwrctrl_periph_disable(AM_HAL_PWRCTRL_PERIPH_IOM0);
  am_hal_pwrctrl_periph_disable(AM_HAL_PWRCTRL_PERIPH_IOM1);
  am_hal_pwrctrl_periph_disable(AM_HAL_PWRCTRL_PERIPH_IOM2);
  am_hal_pwrctrl_periph_disable(AM_HAL_PWRCTRL_PERIPH_IOM3);
  am_hal_pwrctrl_periph_disable(AM_HAL_PWRCTRL_PERIPH_IOM4);
  am_hal_pwrctrl_periph_disable(AM_HAL_PWRCTRL_PERIPH_IOM5);
  am_hal_pwrctrl_periph_disable(AM_HAL_PWRCTRL_PERIPH_ADC);
  am_hal_pwrctrl_periph_disable(AM_HAL_PWRCTRL_PERIPH_UART0);
  am_hal_pwrctrl_periph_disable(AM_HAL_PWRCTRL_PERIPH_UART1);

  // Disable all pads (except UART TX/RX)
  for (int x = 0 ; x < 50 ; x++)
    am_hal_gpio_pinconfig(x, g_AM_HAL_GPIO_DISABLE);

  //Power down CACHE, flashand SRAM
  am_hal_pwrctrl_memory_deepsleep_powerdown(AM_HAL_PWRCTRL_MEM_ALL); // Turn off CACHE and flash
  am_hal_pwrctrl_memory_deepsleep_retain(AM_HAL_PWRCTRL_MEM_SRAM_384K); // Retain all SRAM (0.6 uA)

  // Keep the 32kHz clock running for RTC
  am_hal_stimer_config(AM_HAL_STIMER_CFG_CLEAR | AM_HAL_STIMER_CFG_FREEZE);
  am_hal_stimer_config(AM_HAL_STIMER_XTAL_32KHZ);
#endif
}

void wake_up(void){
#if 0
  // Go back to using the main clock
  am_hal_stimer_config(AM_HAL_STIMER_CFG_CLEAR | AM_HAL_STIMER_CFG_FREEZE);
  am_hal_stimer_config(AM_HAL_STIMER_HFRC_3MHZ);

  // Renable UART0 pins
  am_hal_gpio_pinconfig(48, g_AM_BSP_GPIO_COM_UART_TX);
  am_hal_gpio_pinconfig(49, g_AM_BSP_GPIO_COM_UART_RX);

  // Renable power to UART0
  am_hal_pwrctrl_periph_enable(AM_HAL_PWRCTRL_PERIPH_UART0);

  // Enable ADC
  initializeADC();

  // Enable ADC
  initializeADC();
#endif

  Serial.begin(baudrate_debug_serial);
  delay(100);
  Serial.println();
  Serial.println(F("------ WAKE UP ------"));
  Serial.println(F("powered up board"));

  Wire.begin();
  delay(100);
  //Wire.setClock(1000000);
  delay(100);
  wdt.restart();
  Serial.println(F("started Wire"));

  Serial.println(F("start qwiic switch"));
  if (qwiic_switch.begin(Wire) == false){
      Serial.println(F("Qwiic Power Switch not detected at default I2C address. Please check wiring. Freezing."));
      while (true){;}
  }
  turn_qwiic_switch_off();

  setup_pins();
  turn_gnss_off();
  turn_iridium_off();
}
