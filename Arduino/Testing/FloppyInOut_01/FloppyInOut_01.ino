int stepPin = 3;    // LED connected to digital pin 9
int dirPin = 4;
int dirPinTest = 5;

void setup() {
  pinMode(stepPin,OUTPUT);
  pinMode(dirPin,OUTPUT);
  pinMode(dirPinTest,OUTPUT);
  // nothing happens in setup
  digitalWrite(dirPin,HIGH);
  digitalWrite(dirPinTest,LOW);
}

void loop() {
  digitalWrite(stepPin,HIGH);
  delay(100);
  digitalWrite(stepPin,LOW);
  delay(100);
  
}
