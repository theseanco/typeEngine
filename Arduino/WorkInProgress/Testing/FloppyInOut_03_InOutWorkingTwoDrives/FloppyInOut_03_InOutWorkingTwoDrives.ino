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
  
  if ( inc <= 29 ) {
    digitalWrite(dirPin,LOW);
    digitalWrite(dirPin2,LOW);
    Serial.println("DONE");
  }
  
  else if ( inc <= 60 ) {
  digitalWrite(dirPin, HIGH);
  digitalWrite(dirPin2, HIGH);
  }
  
  
  digitalWrite(stepPin,HIGH);
  delay(30);
  digitalWrite(stepPin,LOW);
  delay(30);
  
  digitalWrite(stepPin2,HIGH);
  delay(30);
  digitalWrite(stepPin2,LOW);
  delay(30);
  
  
  inc = inc + 1;
  inc = inc%60;
  Serial.println(inc);  

}
