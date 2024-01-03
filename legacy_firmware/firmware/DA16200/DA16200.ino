#define WIFI_SERIAL_BAUD 115200


D9 ~AD12(PDMCLK/TX1)
D10 ~AD13(I2SBCLK/RX1)

//#define WIFI_RX 1  (TX pin on Uno)
//#define WIFI_TX 0  (RX pin on Uno)
#define WIFI_RX 9
#define WIFI_TX 8

#define RTC_PWR_KEY 4
#define UART_INSTANCE 1

//Uart Serial1{UART_INSTANCE, WIFI_RX, WIFI_TX};  // Arduino pinout
//UART Serial1{UART_INSTANCE, WIFI_RX, WIFI_TX};


String wifiSSID = "ROS24";
String wifiPass = "Password1!";

int timezoneOffset = 0; //The hours offset from UTC (Mountain time is -6 for daylight savings, and -7 for standard)

Uart WiFiSerial(1, WIFI_TX, WIFI_RX);

void setup() {
  Serial.begin(1000000);

  WiFiSerial.begin(WIFI_SERIAL_BAUD); //Set SoftwareSerial baud

  //Enable DA16200 Module RTC power block
  pinMode(RTC_PWR_KEY,OUTPUT);


  //Enable DA16200 Module RTC power block
  pinMode(RTC_PWR_KEY,OUTPUT);
  digitalWrite(RTC_PWR_KEY,HIGH);

  Serial.println("DA16200 AT Command Example: Connecting to WiFi\n");

  //Listen for ready message ("+INIT:DONE")
  byte count = 0;
  String msg = "";
  while(count<20)
  {
    while( WiFiSerial.available())
    {
      msg += char( WiFiSerial.read());
    }
    if(msg.length() > 5) break;
    count++;
    delay(100);
  }
  msg = msg.substring(3,msg.length()); //Remove NULL,CR,LF characters from response

  if(msg.length()>5)
  {
    Serial.println("Expecting: \"INIT:DONE,(0 or 1)");
    Serial.println("Received: " + msg);
  }
  else
  {
    Serial.println("Failed to receive initialization message.\n" \
                   "Make sure you're using the correct baud rate.\n");
    while(1);
  }

  //Configure module for STA mode
  Serial.println("Sending:AT+WFMODE=0");
   WiFiSerial.println("AT+WFMODE=0");

  //Wait for "OK" response
  while(1)
  {
    msg = "";
    while( WiFiSerial.available())
    {
      msg += char( WiFiSerial.read());
      delay(1);
    }
    Serial.print(msg);
    if(msg.length() > 1) break;
  }

  //Apply a software reset to finish changing the mode
  Serial.println("Sending:AT+RESTART");
   WiFiSerial.println("AT+RESTART");

  //Wait for "OK" response
  while(1)
  {
    msg = "";
    while( WiFiSerial.available())
    {
      msg += char( WiFiSerial.read());
      delay(1);
    }
    Serial.print(msg);
    if(msg.length() > 1) break;
  }

  //Listen for ready message ("+INIT:DONE") after the reset is finished
  count = 0;
  msg = "";
  while(count<20)
  {
    while( WiFiSerial.available())
    {
      msg += char( WiFiSerial.read());
    }
    if(msg.length() > 5) break;
    count++;
    delay(100);
  }

  Serial.println(count);
  Serial.println(msg);
  msg = msg.substring(3,msg.length()); //Remove NULL,CR,LF characters from response

  if(msg.length()>5)
  {
    Serial.println("Expecting: \"INIT:DONE,(0 or 1)");
    Serial.println("Received: " + msg);
  }
  else
  {
    Serial.println("Failed to receive initialization message.\n" \
                   "Continuing anyway...\n");
  }

  //Connect to WiFi using the provided credentials
  Serial.println("Sending:AT+WFJAPA=" + wifiSSID + "," + wifiPass);
   WiFiSerial.println("AT+WFJAPA=" + wifiSSID + "," + wifiPass);

  Serial.println("Waiting for connection response...");
  while(1)
  {
    msg = "";
    while( WiFiSerial.available())
    {
      msg += char( WiFiSerial.read());
      delay(1);
    }

    if(msg.length() > 10) 
    {
      Serial.print("Response:");
      Serial.println(msg);
      break;
    }
  }

  msg = msg.substring(3,msg.length()); //Remove NULL,CR,LF characters from response

  //If connection to AP is successful, response will be WFJAP:1,SSID,IP_ADDRESS, or WJAP:0 if failed
  if(msg.startsWith("WFJAP:1"))
  {
      //Talk to NTP server to get the current time, along with how often to get time sync
      Serial.println("Sending:AT+NWSNTP=1,pool.ntp.org,86400");
       WiFiSerial.println("AT+NWSNTP=1,pool.ntp.org,86400");

      //Wait for "OK" response
      while(1)
      {
        String msg = "";
        while( WiFiSerial.available())
        {
          msg += char( WiFiSerial.read());
          delay(1);
        }
        Serial.print(msg);
        if(msg.length() > 1) break;
      }

      //Provides the correct UTC offset for the current time
      Serial.println("Sending:AT+TZONE="+String(timezoneOffset*3600));
       WiFiSerial.println("AT+TZONE="+String(timezoneOffset*3600));

      //Wait for "OK" response
      while(1)
      {
        String msg = "";
        while( WiFiSerial.available())
        {
          msg += char( WiFiSerial.read());
          delay(1);
        }
        Serial.print(msg);
        if(msg.length() > 1) break;
      }  
  }
  else
  {
    Serial.println("Connection unsucessful :(\n\n" \
                   "Make sure the WiFi credentials are correct, and the module is in the station mode");
    while(1);
  }
}

void loop() {
  //Get the current time
  Serial.println("Sending:AT+TIME");
   WiFiSerial.println("AT+TIME");

  while( WiFiSerial.available())
  {
    Serial.print(char( WiFiSerial.read()));
    delay(1);
  }

  delay(1000);
}



