int stepPin = 3; //drive 1 
int dirPin = 4;
int stepPin2 = 5; //drive 2
int dirPin2 = 6;
int inc = 0;

void setup() {
    Serial.begin(9600);
  pinMode(stepPin,OUTPUT);
  pinMode(stepPin2,OUTPUT); 
  pinMode(dirPin,OUTPUT);
  pinMode(dirPin2,OUTPUT);
}

void loop() {
  
  if ( inc <= 79 ) {
    digitalWrite(dirPin,LOW);
    digitalWrite(dirPin2,LOW);
    Serial.println("DONE");
  }
  
  else if ( inc <= 160 ) {
  digitalWrite(dirPin, HIGH);
  digitalWrite(dirPin2, HIGH);
  }
  
  
  digitalWrite(stepPin,HIGH);
  delay(10);
  digitalWrite(stepPin,LOW);
  delay(10);
  
  digitalWrite(stepPin2,HIGH);
  delay(10);
  digitalWrite(stepPin2,LOW);
  delay(10);
  
  
  inc = inc + 1;
  inc = inc%160;
  Serial.println(inc);  

}
