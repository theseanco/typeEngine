int stepPin = 3;    // LED connected to digital pin 9
int dirPin = 4;
int dirPinTest = 5;
int inc = 0;

void setup() {
    Serial.begin(9600);
  pinMode(stepPin,OUTPUT);
  pinMode(dirPin,OUTPUT);
  pinMode(dirPinTest,OUTPUT);
  // nothing happens in setup
  digitalWrite(dirPin,HIGH);
  digitalWrite(dirPinTest,LOW);
}

void loop() {
  
  if ( inc <= 29 ) {
    digitalWrite(dirPin,LOW);
    Serial.println("DONE");
  }
  
  else if ( inc <= 60 ) {
  digitalWrite(dirPin, HIGH);
  }
  
  digitalWrite(stepPin,HIGH);
  delay(4);
  digitalWrite(stepPin,LOW);
  delay(4);
  inc = inc + 1;
  inc = inc%60;
  Serial.println(inc);  

}
