// define sensor 
#include "DHT.h"
#define DHTPIN 2     // Digital pin connected to the DHT sensor
#define DHTTYPE DHT22   // DHT 22  (AM2302), AM2321
// Initialize DHT sensor.
DHT dht(DHTPIN, DHTTYPE);

// define led
#include <Adafruit_NeoPixel.h>
#ifdef __AVR__
#include <avr/power.h> // Required for 16 MHz Adafruit Trinket
#endif
#define PIN        11 // On Trinket or Gemma, suggest changing this to 1
#define NUMPIXELS 50 // Popular NeoPixel ring size
Adafruit_NeoPixel pixels(NUMPIXELS, PIN, NEO_GRB + NEO_KHZ800);

// define time
#define DELAY 50
unsigned long previousMillis = 0; 
const long interval = 350;  

void setup() {
  // initiate sensor 
  Serial.begin(9600);
  Serial.println(F("DHTxx test!"));
  dht.begin();
  
  // initiate led
  #if defined(__AVR_ATtiny85__) && (F_CPU == 16000000)
    clock_prescale_set(clock_div_1);
  #endif // END of Trinket-specific code.
  pixels.begin(); // INITIALIZE NeoPixel strip object (REQUIRED)

  // sound
  pinMode(12, OUTPUT);
}


void loop() {

  // sensor part

  float h = dht.readHumidity();
  // Read temperature as Celsius (the default)
  float t = dht.readTemperature();
  // Read temperature as Fahrenheit (isFahrenheit = true)
  float f = dht.readTemperature(true);

  // Check if any reads failed and exit early (to try again).
  if (isnan(h) || isnan(t) || isnan(f)) {
    Serial.println(F("Failed to read from DHT sensor!"));
    return;
  }

  // Compute heat index in Fahrenheit (the default)
  float hif = dht.computeHeatIndex(f, h);
  // Compute heat index in Celsius (isFahreheit = false)
  float hic = dht.computeHeatIndex(t, h, false);

  Serial.print(F("Humidity: "));
  Serial.print(h);
  Serial.print(F("%  Temperature: "));
  Serial.print(t);
  Serial.print(F("°C "));
  Serial.print(f);
  Serial.print(F("°F  Heat index: "));
  Serial.print(hic);
  Serial.print(F("°C "));
  Serial.print(hif);
  Serial.println(F("°F"));

  
  // led part
  pixels.clear(); // Set all pixel colors to 'off'

  unsigned long currentMillis = millis();
  
  for(int i=0; i<NUMPIXELS; i++) { // For each pixel...
    
    if(h >= 50  || t >= 28) {
      pixels.setPixelColor(i, pixels.Color(210 - (h - 0.3) * 300, (h - 0.3) * 0.3 , (h - 0.3) * 0.3));
      pixels.show();   // Send the updated pixel colors to the hardware.
     
      if (currentMillis - previousMillis >= interval) {
        // save the last time you blinked the LED
        previousMillis = currentMillis;
      } 
       
      // sound part
      tone (12, 261 ); //Middle C
      delay(DELAY);
            
      tone (12, 261 ); //Middle C
      delay(DELAY);

      tone (12, 392 ); //G
      delay(DELAY);

      tone (12, 392); //G
      delay(DELAY);

      tone (12, 440 ); //A
      delay(DELAY);

      tone (12, 440); //A
      delay(DELAY);

      tone (12, 261 ); //C
      delay(DELAY);

    }
    
    else {
      pixels.setPixelColor(i, pixels.Color(210, 0 , 0));
      pixels.show();   // Send the updated pixel colors to the hardware.
      
      if (currentMillis - previousMillis >= interval) {
        // save the last time you blinked the LED
        previousMillis = currentMillis;
      }

      // sound part
      tone (12, 261); //Middle C
      delay(DELAY);

      tone (12, 261); //Middle C
      delay(DELAY);

      tone (12, 261); //Middle C
      delay(DELAY);

      tone (12, 261); //Middle C
      delay(DELAY);

      tone (12, 261); //Middle C
      delay(DELAY);

      tone (12, 261); //Middle C
      delay(DELAY);

      tone (12, 261); //Middle C
      delay(DELAY);
      
    }
    
  }
  
}
