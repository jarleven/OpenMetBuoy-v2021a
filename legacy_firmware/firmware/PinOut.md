### For experimenting with WiFi

### The Qwiic connector
```
4 -- SCL   Yellow
3 -- SDA   Blue
2 -- 3.3v  Red
1 -- GND   Black
```



https://learn.sparkfun.com/tutorials/dialog-ulp-wifi-da16200-r3-shield-hookup-guide/introduction

```
  ARDUINO --> WiFi Shield		Artemis Redboard module
  8       --> RX1			 AD32 (SCCIO)
  9       --> TX1			 AD12 (PDMCLK/TX1)
  4       --> RTC_PWR_KEY		 ~D22 (PDMCLK/SWO)
  3.3V    --> 3.3V
  GND     --> GND
```

### OpenLog-Artemis
```
--- 6 pin header ---
GND
3.3V
32	AD32
TX	AD12
RX	AD13
11	AD11


```

### RedBoard-Artemis
```
Arduino		Artemis
''''''''''''''''''''''''''
--- I2C 0 ---
~D12		(SCL0/SCK0)~D5
~D13		(SDA0/MISO0/I2SDAT)~D6

--- I2C 2 ---
~D0/RXI-1	(SDA2/MISO2/RX1)~D25
~D6		(SCL2/SCK2)~D27

--- I2C 3 ---
 D24 TP12	(SCL1/SCK1/TX1/SCCLK)D8
 D25 TP13	(SDA1/MISO1/RX1/SCCIO)D9

--- I2C 4  Qwiic ---
~D15 SCL	(SCL4/SCK4/TX1)~D39
 D14 SDA	(SDA4/MISO4/RX1)D40

--- UART ---
TXO-0 ~D48(TX0/SCL5/SCK5)
RXI-0 ~D49(RX0/SDA5/MISO5)
```


### SparkFun Artemis Global Tracker
```  
--- Supercap carger ---
  D22 Supercap charger
  AD32 Header J10
  AD12 Header J11

--- GNSS ---

D8 --- (SCL1/SCK1/TX1/SCCLK)D8
D9 --- (SDA1/SDI1/RX1/SCCIO)D9

--- Headers ---
    
   3.3v
   D4
   D35
   D5
   D6
   D7
   GND
  
  AD32
   D43
   D42
  AD31
  
  AD29
  AD11
   D15
  AD12
  
   D37
  
  --- Qwiic ---
   D39  SCL4
   D40  SDA4
   VCC
   GND
  
  --- PTH ---
   D8	SCL/1
   D9	SDA/1
   VCC
   GND
```
