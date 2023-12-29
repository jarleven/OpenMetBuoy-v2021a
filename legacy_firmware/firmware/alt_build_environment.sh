#!/bin/bash

TODO:
  Using later versions of Arduino 
  we need to replace the 
  #include <stdlib.h>
  to use dtostrf() on the artemis you must first:
  #include <avr/dtostrf.h>
  https://github.com/arduino/ArduinoCore-sam/blob/master/cores/arduino/avr/dtostrf.c

# Libraries from the Artemis OpenLog project

arduino-cli lib install "SdFat@2.2.0"
arduino-cli lib install "SparkFun 9DoF IMU Breakout - ICM 20948 - Arduino Library"
arduino-cli lib install "SparkFun Qwiic Scale NAU7802 Arduino Library"
arduino-cli lib install "SparkFun VL53L1X 4m Laser Distance Sensor"
arduino-cli lib install "SparkFun VCNL4040 Proximity Sensor Library"
arduino-cli lib install "SparkFun MCP9600 Thermocouple Library"
arduino-cli lib install "SparkFun High Precision Temperature Sensor TMP117 Qwiic"
arduino-cli lib install "SparkFun MS5637 Barometric Pressure Library"
arduino-cli lib install "SparkFun LPS25HB Pressure Sensor Library"
arduino-cli lib install "SparkFun 9DoF IMU Breakout - ICM 20948 - Arduino Library"
arduino-cli lib install "SparkFun I2C Mux Arduino Library"
arduino-cli lib install "SparkFun CCS811 Arduino Library"
arduino-cli lib install "SparkFun BME280"
arduino-cli lib install "SparkFun VEML6075 Arduino Library"
arduino-cli lib install "SparkFun PHT MS8607 Arduino Library"
arduino-cli lib install "SparkFun SGP30 Arduino Library"
arduino-cli lib install "SparkFun u-blox GNSS Arduino Library"     # ### Multiple versions available
arduino-cli lib install "SparkFun Qwiic Scale NAU7802 Arduino Library"
arduino-cli lib install "SparkFun SCD30 Arduino Library"
arduino-cli lib install "SparkFun Qwiic Humidity AHT20"
arduino-cli lib install "SparkFun SHTC3 Humidity and Temperature Sensor Library"
arduino-cli lib install "SparkFun ADS122C04 ADC Arduino Library"
arduino-cli lib install "SparkFun MicroPressure Library"
arduino-cli lib install "SparkFun Particle Sensor Panasonic SN-GCJA5
arduino-cli lib install "SparkFun SGP40 Arduino Library"
arduino-cli lib install "SparkFun SDP3x Arduino Library"
arduino-cli lib install "SparkFun Qwiic Button and Qwiic Switch Library"
arduino-cli lib install "SparkFun Bio Sensor Hub Library"
arduino-cli lib install "SparkFun 6DoF ISM330DHCX"
arduino-cli lib install "SparkFun MMC5983MA Magnetometer Arduino Library"
arduino-cli lib install "SparkFun ADS1015 Arduino Library"
arduino-cli lib install "SparkFun KX13X Arduino Library"

