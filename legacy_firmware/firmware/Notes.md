
´´´Bash

arduino-cli version

arduino-cli board list



´´´

´´´Bash

grep "pinMode" -ri
board_control.cpp:  pinMode(LED, OUTPUT);
board_control.cpp:  pinMode(LED, OUTPUT); // Make the LED pin an output
board_control.cpp:  pinMode(geofencePin, INPUT); // Configure the geofence pin as an input
board_control.cpp:  pinMode(iridiumRI, INPUT); // Configure the Iridium Ring Indicator as an input
board_control.cpp:  pinMode(iridiumNA, INPUT); // Configure the Iridium Network Available as an input
board_control.cpp:  pinMode(superCapPGOOD, INPUT); // Configure the super capacitor charger PGOOD input
board_control.cpp:  pinMode(busVoltageMonEN, OUTPUT); // Make the Bus Voltage Monitor Enable an output
board_control.cpp:  pinMode(gnssEN, OUTPUT); // Configure the pin which enables power for the ZOE-M8Q GNSS



 grep "begin_I2C" -ri /home/jarleven/Arduino/
/home/jarleven/Arduino/libraries/Adafruit_LIS3MDL/examples/lis3mdl_demo/lis3mdl_demo.ino:  if (! lis3mdl.begin_I2C()) {          // hardware I2C mode, can pass in address & alt Wire
/home/jarleven/Arduino/libraries/Adafruit_LIS3MDL/Adafruit_LIS3MDL.cpp:bool Adafruit_LIS3MDL::begin_I2C(uint8_t i2c_address, TwoWire *wire) {
/home/jarleven/Arduino/libraries/Adafruit_LIS3MDL/Adafruit_LIS3MDL.h:  bool begin_I2C(uint8_t i2c_addr = LIS3MDL_I2CADDR_DEFAULT,
´´´

