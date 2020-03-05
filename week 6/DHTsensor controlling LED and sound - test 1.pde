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
#define DELAYVAL 20 // Time (in milliseconds) to pause between pixels
#define DELAY 50

//// Store LED color, default RGB - 255,255,255
//int redVal = 255;
//int blueVal = 255;
//int greenVal = 255;


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

  for(int i=0; i<NUMPIXELS; i++) { // For each pixel...
    
    if(h >= 50  || t >= 28) {
      pixels.setPixelColor(i, pixels.Color(210 - (h - 0.3) * 300, (h - 0.3) * 0.3 , (h - 0.3) * 0.3));
      pixels.show();   // Send the updated pixel colors to the hardware.
      delay(DELAYVAL); // Pause before next pass through loop
    } 
    else {
      pixels.setPixelColor(i, pixels.Color(210, 0 , 0));
      pixels.show();   // Send the updated pixel colors to the hardware.
      delay(DELAYVAL); // Pause before next pass through loop 
    }
  }


  // sound part
  if(h >= 50  || t >= 28) {
    tone (12, 261 + (h - 0.3) * 10); //Middle C
    delay(DELAY);

    tone (12, 277 + (h - 0.3) * 2); //C#
    delay(DELAY);

    tone (12, 294 + (h - 0.3) * 3); //D
    delay(DELAY);
  
    tone (12, 311 + (h - 0.3) * 2); //D#
    delay(DELAY);
   
    tone (12, 330 + (h - 0.3) * 7); //E
    delay(DELAY);

  }
  else {
    tone (12, 261);
    delay(DELAY);

    tone (12, 277); //C#
    delay(DELAY);

    tone (12, 294); //D
    delay(DELAY);
  
    tone (12, 311); //D#
    delay(DELAY);
   
    tone (12, 330); //E
    delay(DELAY);

  }
}
