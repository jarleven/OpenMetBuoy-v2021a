#!/bin/bash


sudo apt-get update
sudo apt-get upgrade -y 
sudo apt remove -y brltty
# Rebooting works best after changing user rights on the serialport
sudo usermod -a -G tty $USER
sudo usermod -a -G dialout $USER

sudo apt-get install -y curl git build-essential ffmpeg arduino-mk && sudo apt-get clean

sudo apt-get install python3-pip
python3 -m pip install icecream numpy matplotlib scipy   

# From Arduino-CLI, slightly different than in the Dockerfile
cd $HOME
rm install.sh
curl -fsSL https://raw.githubusercontent.com/arduino/arduino-cli/master/install.sh | sh

arduino-cli config init

arduino-cli config add board_manager.additional_urls https://raw.githubusercontent.com/sparkfun/Arduino_Apollo3/main/package_sparkfun_apollo3_index.json

# TODO: Comments are from functionality test mode legacy build (Original build)
arduino-cli core update-index
arduino-cli core install "Sparkfun:apollo3@1.2.1"
# Using board 'artemis' from platform in folder: /home/jrmet/.arduino15/packages/SparkFun/hardware/apollo3/1.2.1
# Using core 'arduino' from platform in folder: /home/jrmet/.arduino15/packages/SparkFun/hardware/apollo3/1.2.1

arduino-cli lib update-index



#TODO:
#  Using later versions of Arduino 
#  we need to replace the 
#  #include <stdlib.h>
#  to use dtostrf() on the artemis you must first:
#  #include <avr/dtostrf.h>
#  https://github.com/arduino/ArduinoCore-sam/blob/master/cores/arduino/avr/dtostrf.c

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
airduino-cli lib install "SparkFun Particle Sensor Panasonic SN-GCJA5"
arduino-cli lib install "SparkFun SGP40 Arduino Library"
arduino-cli lib install "SparkFun SDP3x Arduino Library"
arduino-cli lib install "SparkFun Qwiic Button and Qwiic Switch Library"
arduino-cli lib install "SparkFun Bio Sensor Hub Library"
arduino-cli lib install "SparkFun 6DoF ISM330DHCX"
arduino-cli lib install "SparkFun MMC5983MA Magnetometer Arduino Library"
arduino-cli lib install "SparkFun ADS1015 Arduino Library"
arduino-cli lib install "SparkFun KX13X Arduino Library"

