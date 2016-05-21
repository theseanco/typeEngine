/* Blink without Delay

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
const int stepPin =  3;
const int dirPin = 4;

//setting pin states as low to start
int stepState = LOW; 
int dirState = LOW;  

// unsigned long because it holds time
unsigned long previousMillis1 = 0;  

// set intervals (to be changed later)
int interval1 = 10;

//set incrementers
int inc1 = 0;

void setup() {
  // set the digital pin as output:
  pinMode(stepPin, OUTPUT);
  pinMode(dirPin, OUTPUT);
}

void loop() {
  // here is where you'd put code that needs to be running all the time.

  // check to see if it's time to blink the LED; that is, if the
  // difference between the current time and last time you blinked
  // the LED is bigger than the interval at which you want to
  // blink the LED.
  unsigned long currentMillis = millis();

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
    if ( inc <= 79 ) {
      dirState = LOW;
    }
    else if ( inc <= 160 ) {
      dirState = HIGH;
    }
    
    inc1 = inc1%160;
    
    // set the LED with the ledState of the variable:
    digitalWrite(stepPin, stepState);
    digitalWrite(dirPin, dirState);
  }
}
