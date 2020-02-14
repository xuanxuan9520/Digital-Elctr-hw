const int ledPin = 13;

const int ldrPin = A0;

// variable to store the value coming from the sensor
int ldrStatus = 0; 

void setup() {
  //sets serial port for communication
  Serial.begin(9600); 

  pinMode(ledPin, OUTPUT);
  pinMode(ldrPin, INPUT);
}

void loop() {
  // read the value from the sensor
  int ldrStatus = analogRead(ldrPin); 

  //prints the values coming from the sensor on the screen
  Serial.println(ldrStatus); 


  if (ldrStatus <= 30) {

    digitalWrite(ledPin, HIGH);

    Serial.print("Its DARK, Turn on the LED : ");

    Serial.println(ldrStatus);

    } 
    
    else {

      digitalWrite(ledPin, LOW);

      Serial.print("Its BRIGHT, Turn off the LED : ");

      Serial.println(ldrStatus);

      }

}
