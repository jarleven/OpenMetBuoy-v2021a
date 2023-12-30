#!/bin/bash

#
# Create the build environment for the Arduino Sparkfun Artemis platform
# The steps are as in the Dockerfile (thanks @gauteh)
#
# The script was created and tested on : Ubuntu 22.04.3 LTS \n \l
#
#
#  arduino-cli compile -v -b SparkFun:apollo3:amap3redboard .
#  arduino-cli upload --port /dev/ttyUSB0 -v -b SparkFun:apollo3:amap3redboard .
#
# SparkFun OpenLog Artemis (without IMU) https://www.sparkfun.com/products/19426
#     https://github.com/sparkfun/OpenLog_Artemis
#     https://github.com/sparkfun/OpenLog_Artemis_GNSS_Logger
#
#     arduino-cli compile -v -b SparkFun:apollo3:sfe_artemis_atp .
#
#        Device found at address 0x41 Qwiic Power Switch
#        Device found at address 0x6B 6DoF IMU Sparkfun ISM330DHCX
#        Device found at address 0x42 ZOE-M8Q GNSS
#        Device found at address 0x7E ZOE-M8Q GNSS

#
# Log serialport output :   screen /dev/ttyUSB0 1000000
# Exit screen with :        ctrl-A k y
#
# Arduino CLI 
#    arduino-cli version       # Print version
#    arduino-cli board list    # List connected boards
#    arduino-cli board listall # List installed boards
#    arduino-cli lib list      # List installed libraries
#

# TODO cleanup this list:
# I2C device found at address 0x19  !	Magnetic compass
# I2C device found at address 0x41  ! Qwiic switch
# I2C device found at address 0x42  !	GNSS
# I2C device found at address 0x50  !	Kun MicroMod 2x, ESP32 og MicroProcessor
# I2C device found at address 0x6B  ! 6DoF
# I2C device found at address 0x7E 


sudo apt-get update
sudo apt-get upgrade -y 
sudo apt remove -y brltty
# Rebooting works best after changing user rights on the serialport
sudo usermod -a -G tty $USER
sudo usermod -a -G dialout $USER

sudo apt-get install -y curl git build-essential ffmpeg arduino-mk && sudo apt-get clean

# From Arduino-CLI, slightly different than in the Dockerfile
curl -fsSL https://raw.githubusercontent.com/arduino/arduino-cli/master/install.sh | sh

arduino-cli config init

arduino-cli config add board_manager.additional_urls https://raw.githubusercontent.com/sparkfun/Arduino_Apollo3/main/package_sparkfun_apollo3_index.json

# TODO: Comments are from functionality test mode legacy build (Original build)
arduino-cli core update-index
arduino-cli core install "Sparkfun:apollo3@1.2.1"
# Using board 'artemis' from platform in folder: /home/jrmet/.arduino15/packages/SparkFun/hardware/apollo3/1.2.1
# Using core 'arduino' from platform in folder: /home/jrmet/.arduino15/packages/SparkFun/hardware/apollo3/1.2.1



arduino-cli lib update-index

arduino-cli lib install "Embedded Template Library ETL"                    # 19.3.9 
touch $HOME/Arduino/libraries/Embedded_Template_Library_ETL/src/etl.h
arduino-cli lib install Time                                               # 1.6
arduino-cli lib install "SparkFun Qwiic Power Switch Arduino Library"      # 1.0.0
arduino-cli lib install "SparkFun u-blox GNSS Arduino Library@2.0.2"       # 1.0.0 
arduino-cli lib install IridiumSBDi2c                                      # 3.0.1
arduino-cli lib install "Adafruit LSM6DS@4.3.1"                            #  4.2.0
arduino-cli lib install "Adafruit BusIO@1.7.2"                             # 1.7.2
arduino-cli lib install "Adafruit LIS3MDL"                                 # 1.0.7
arduino-cli lib install "Adafruit AHRS@2.2.4"                              # 2.2.4
arduino-cli lib install "OneWire@2.3.6"                                    # 2.3.5


cd $HOME/Arduino/libraries
rm -rf Adafruit_BusIO
git clone -b "fix/SPI_with_Artemis" --depth=1 https://github.com/jerabaul29/Adafruit_BusIO.git

rm -rf Adafruit_LSM6DS
git clone -b "feat/propagate_bool_flags" --depth=1 https://github.com/jerabaul29/Adafruit_LSM6DS.git

rm -rf OneWire
git clone -b "feat/Artemis_compatible" --depth=1 https://github.com/jerabaul29/OneWire.git

cd $HOME

git clone --depth=1 https://github.com/jerabaul29/OpenMetBuoy-v2021a.git

cd OpenMetBuoy-v2021a/legacy_firmware/firmware/functionality_test_mode/
mv tracker.ino functionality_test_mode.ino

arduino-cli compile -v -b SparkFun:apollo3:artemis .

#
# root@fb25dd462854:/work/OpenMetBuoy-v2021a/legacy_firmware/firmware/scanner# arduino-cli compile -v -b SparkFun:apollo3:amap3redboard .
#
#
# sudo docker run -it --device=/dev/ttyUSB0 omb_compiler:latest /bin/bash
#
# arduino-cli compile -v -b SparkFun:apollo3:amap3redboard .
# arduino-cli upload --port /dev/ttyUSB0 -v -b SparkFun:apollo3:amap3redboard .
#
# screen /dev/ttyUSB0 1000000
# ctrl-A k y
#
#
#
# root@8249e876ee23:/work/OpenMetBuoy-v2021a/legacy_firmware/firmware/scanner# arduino-cli version
# arduino-cli  Version: 0.34.2 Commit: 963c1a76 Date: 2023-09-11T10:05:42Z
#
