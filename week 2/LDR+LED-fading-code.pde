const int ledPin = 9;  // the PWM pin the LED is attached to
const int ldrPin = A0;
int brightness = 0;    // how bright the LED is
int fadeAmount = 5;    // how many points to fade the LED by


// variable to store the value coming from the sensor
int ldrStatus = 0; 

// the setup routine runs once when you press reset:
void setup() {
  //sets serial port for communication
  Serial.begin(9600);
  
  // declare pin 9 to be an output:
  pinMode(ledPin, OUTPUT);
  pinMode(ldrPin, INPUT);
}

// the loop routine runs over and over again forever:
void loop() {

  // read the value from the sensor
  int ldrStatus = analogRead(ldrPin); 

  //prints the values coming from the sensor on the screen
  Serial.println(ldrStatus); 

  if (ldrStatus <= 30) {

    // set the brightness of pin 9:
    analogWrite(ledPin, brightness);

    // change the brightness for next time through the loop:
    brightness = brightness + fadeAmount;

    // reverse the direction of the fading at the ends of the fade:
    if (brightness <= 0 || brightness >= 255) {
      fadeAmount = -fadeAmount;
    }
      // wait for 30 milliseconds to see the dimming effect
    delay(30);
  }

  else {

    digitalWrite(ledPin, LOW);

    Serial.print("Its BRIGHT, Turn off the LED : ");

    Serial.println(ldrStatus);

    }
    
}
