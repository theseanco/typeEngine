/* 

This code is based on the following:

Blink without Delay

 Turns on and off a light emitting diode (LED) connected to a digital
 pin, without using the delay() function.  This means that other code
 can run at the same time without being interrupted by the LED code.

 The circuit:
 * LED attached from pin 13 to ground.
 * Note: on most Arduinos, there is already an LED on the board
 that's attached to pin 13, so no hardware is needed for this example.

 created 2005
 by David A. Mellis
 modified 8 Feb 2010
 by Paul Stoffregen
 modified 11 Nov 2013
 by Scott Fitzgerald


 This example code is in the public domain.

 http://www.arduino.cc/en/Tutorial/BlinkWithoutDelay
 */

// constants won't change. Used here to set a pin number :
const int stepPin =  2;
const int dirPin = 3;
const int stepPin2 =  4;
const int dirPin2 = 5;
const int relay = 6;
const int relay2 = 7;
const int relay3 = 8;
const int relay4 = 9;
const int relay5 = 10;
const int relay6 = 11;
const int relay7 = 12;
const int relay8 = 13;

//setting pin states as low to start
int stepState = LOW; 
int dirState = LOW; 
int stepState2 = LOW; 
int dirState2 = LOW; 
int relayState = LOW;
int relayState2 = LOW;
int relayState3 = LOW;
int relayState4 = LOW;
int relayState5 = LOW;
int relayState6 = LOW;
int relayState7 = LOW;
int relayState8 = LOW;

// unsigned long because it holds time
unsigned long previousMillis1 = 0;  
unsigned long previousMillis2 = 0;  
unsigned long previousMillis3 = 0;  
unsigned long previousMillis4 = 0; 
unsigned long previousMillis5 = 0;  
unsigned long previousMillis6 = 0; 
unsigned long previousMillis7 = 0;  
unsigned long previousMillis8 = 0; 
unsigned long previousMillis9 = 0;  
unsigned long previousMillis10 = 0; 

// set intervals (to be changed later)
int interval1 = 10000;
int interval2 = 10000;
int interval3 = 10000;
int interval4 = 10000;
int interval5 = 10000;
int interval6 = 10000;
int interval7 = 10000;
int interval8 = 10000;
int interval9 = 10000;
int interval10 = 10000;


//set incrementers
int inc1 = 0;
int inc2 = 0;
int inc3 = 0;
int inc4 = 0;
int inc5 = 0;
int inc6 = 0;
int inc7 = 0;
int inc8 = 0;
int inc9 = 0;
int inc10 = 0;

//grabbing ints from serial
char serialGrab = 0;

void setup() {
  // set the digital pin as output:
  pinMode(stepPin, OUTPUT);
  pinMode(dirPin, OUTPUT);
  pinMode(stepPin2, OUTPUT);
  pinMode(dirPin2, OUTPUT);
  pinMode(relay, OUTPUT);
  pinMode(relay2, OUTPUT);
  pinMode(relay3, OUTPUT);
  pinMode(relay4, OUTPUT);
  pinMode(relay5, OUTPUT);
  pinMode(relay6, OUTPUT);
  pinMode(relay7, OUTPUT);
  pinMode(relay8, OUTPUT);
  Serial.begin(115200);
}

void loop() {
  
    // Here are all of the milis loops controlling the actuation of devices
  unsigned long currentMillis = millis();
  
  //wait for serial info
  while (Serial.available() > 0 ) {
   int val = Serial.parseInt();
   int val2 = Serial.parseInt();
   int val3 = Serial.parseInt();
   int val4 = Serial.parseInt();
   int val5 = Serial.parseInt();
   int val6 = Serial.parseInt();
   int val7 = Serial.parseInt();
   int val8 = Serial.parseInt();
   int val9 = Serial.parseInt();
   int val10 = Serial.parseInt();
   int val11 = Serial.parseInt();
   interval1 = val;
   interval2 = val2;
   interval3 = val3;
   interval4 = val4;
   interval5 = val5;
   interval6 = val6;
   interval7 = val7;
   interval8 = val8;
   interval9 = val9;
   interval10 = val10;
  Serial.println(interval1)  ; 
  Serial.println(interval2);
  Serial.println(val10);
  }

  if (currentMillis - previousMillis1 >= interval1) {
    // save the last time you blinked the LED
    previousMillis1 = currentMillis;

    // if the LED is off turn it on and vice-versa:
    if (stepState == LOW) {
      stepState = HIGH;
    } else {
      stepState = LOW;
      //increment as one 'cycle'
      inc1 = inc1 + 1;
    }

    //control motor direction
    if ( inc1 <= 79 ) {
      dirState = LOW;
    }
    else if ( inc1 <= 160 ) {
      dirState = HIGH;
    }
    
    inc1 = inc1%160;
    
    // set the LED with the ledState of the variable:
    digitalWrite(stepPin, stepState);
    digitalWrite(dirPin, dirState);
  }
  
  if (currentMillis - previousMillis2 >= interval2) {
    // save the last time you blinked the LED
    previousMillis2 = currentMillis;

    // if the LED is off turn it on and vice-versa:
    if (stepState2 == LOW) {
      stepState2 = HIGH;
    } else {
      stepState2 = LOW;
      //increment as one 'cycle'
      inc2 = inc2 + 1;
    }

    //control motor direction
    if ( inc2 <= 79 ) {
      dirState2 = LOW;
    }
    else if ( inc1 <= 160 ) {
      dirState2 = HIGH;
    }
    
    inc2 = inc2%160;
    
    // set the LED with the ledState of the variable:
    digitalWrite(stepPin2, stepState2);
    digitalWrite(dirPin2, dirState2);
  }
  
  //these for the relays which require no stepper pin
  if (currentMillis - previousMillis3 >= interval3) {
    previousMillis3 = currentMillis;
    
    if (relayState == LOW) {
      relayState = HIGH;
    } else {
      relayState = LOW;
    }
    
    digitalWrite(relay,relayState);
  }
  
  //RELAY 2
    if (currentMillis - previousMillis4 >= interval4) {
    previousMillis4 = currentMillis;
    
    if (relayState2 == LOW) {
      relayState2 = HIGH;
    } else {
      relayState2 = LOW;
    }
    
    digitalWrite(relay2,relayState2);
  }
  
  //RELAY 3
    if (currentMillis - previousMillis5 >= interval5) {
    previousMillis5 = currentMillis;
    
    if (relayState3 == LOW) {
      relayState3 = HIGH;
    } else {
      relayState3 = LOW;
    }
    
    digitalWrite(relay3,relayState3);
  }
  
  //RELAY 4
    if (currentMillis - previousMillis6 >= interval6) {
    previousMillis6 = currentMillis;
    
    if (relayState4 == LOW) {
      relayState4 = HIGH;
    } else {
      relayState4 = LOW;
    }
    
    digitalWrite(relay4,relayState4);
  }
  
  //RELAY 5
    if (currentMillis - previousMillis7 >= interval7) {
    previousMillis7 = currentMillis;
    
    if (relayState5 == LOW) {
      relayState5 = HIGH;
    } else {
      relayState5 = LOW;
    }
    
    digitalWrite(relay5,relayState5);
  }
  
  //RELAY 6
    if (currentMillis - previousMillis8 >= interval8) {
    previousMillis8 = currentMillis;
    
    if (relayState6 == LOW) {
      relayState6 = HIGH;
    } else {
      relayState6 = LOW;
    }
    
    digitalWrite(relay6,relayState6);
  }
  
  //RELAy 7
    if (currentMillis - previousMillis9 >= interval9) {
    previousMillis9 = currentMillis;
    
    if (relayState7 == LOW) {
      relayState7 = HIGH;
    } else {
      relayState7 = LOW;
    }
    
    digitalWrite(relay7,relayState7);
  }
  
  //RELAY 8
    if (currentMillis - previousMillis10 >= interval10) {
    previousMillis10 = currentMillis;
    
    if (relayState8 == LOW) {
      relayState8 = HIGH;
    } else {
      relayState8 = LOW;
    }
    
    digitalWrite(relay8,relayState8);
  }
  
  
}
