/*  =====================================================================
    MINI WEATHER STATION  -  ESP32 side (MYOSA motherboard)
    Tool : VS Code + PlatformIO (libraries are listed in platformio.ini
           and download automatically on the first build)

    The ESP32 does the main work:
      - reads the BMP180 (temperature + pressure, altitude from pressure)
      - keeps max / min of temperature and pressure
      - watches how fast pressure falls over 3 hours:
            fall >= 1.0 hPa  -> RAIN LIKELY
            fall >= 3.0 hPa  -> STORM WARNING
            rise >= 1.0 hPa  -> IMPROVING
      - shows everything on the MYOSA OLED (pages change every 4 s)
      - sends a status to the 8051 every 2 s (9600 baud) as "#S", "#I",
        "#R" or "#W"  ('#' marks the start, then the letter):
            'S' stable   'I' improving   'R' rain likely   'W' storm warning
        The 8051 drives the warning LED and the buzzer.

    SIMULATED 8051 (Proteus): the status goes out on the USB cable
    (Serial, 9600 baud) -> laptop COM port -> Proteus COMPIM -> 8051 RXD.
    Close the PlatformIO Serial Monitor while Proteus is running, because
    only one program can use the COM port at a time.
    The same status also goes out on GPIO 25 (Serial2) for a real 8051.

    DEMO MODE: connect GPIO 27 to GND. Pressure is made to fall by
    0.1 hPa every 2 s, so "RAIN LIKELY" comes after ~20 s and
    "STORM WARNING" after ~60 s. Remove the wire for real data.
    ===================================================================== */

#include <Arduino.h>
#include <Wire.h>
#include <Adafruit_BMP085.h>
#include <Adafruit_GFX.h>
#include <Adafruit_SSD1306.h>

/* ---------- pins ---------- */
#define SDA_PIN     21
#define SCL_PIN     22
#define TX_TO_8051  25      // -> 8051 P3.0 (RXD)
#define RX_UNUSED   26      // not used
#define DEMO_PIN    27      // tie to GND for demo mode

/* ---------- I2C addresses ---------- */
#define OLED_ADDR   0x3C    // MYOSA OLED (SSD1306)

/* ---------- settings ---------- */
#define SLOTS       18            // 18 x 10 min = 3 hour window
#define SLOT_MS     600000UL      // 10 minutes
#define RAIN_DROP   1.0           // hPa
#define STORM_DROP  3.0           // hPa
#define READ_MS     2000UL        // read sensors every 2 s
#define PAGE_MS     4000UL        // change OLED page every 4 s

Adafruit_BMP085  bmp;
Adafruit_SSD1306 oled(128, 64, &Wire, -1);

bool bmpOK = false, oledOK = false, firstRead = true;
float t, p, a;
float tmax, tmin, pmax, pmin;
float hist[SLOTS];
int   slot = 0;
float drop = 0;                 // old - now  (+ve = pressure falling)
char  state = 'S';
int   page = 0;
float demoOffset = 0;

void i2cScan() {
  Serial.println("I2C devices found:");
  for (uint8_t addr = 1; addr < 127; addr++) {
    Wire.beginTransmission(addr);
    if (Wire.endTransmission() == 0) Serial.printf("  0x%02X\n", addr);
  }
}

/* ---------- read sensors + weather logic ---------- */
void updateWeather() {
  t = bmp.readTemperature();
  p = bmp.readPressure() / 100.0;            // Pa -> hPa

  if (digitalRead(DEMO_PIN) == LOW) demoOffset += 0.1;   // simulate falling pressure
  else                              demoOffset = 0;
  p -= demoOffset;

  a = 44330.0 * (1.0 - pow(p / 1013.25, 0.1903));        // altitude estimate

  if (firstRead) {                           // first reading: fill history, set max/min
    for (int i = 0; i < SLOTS; i++) hist[i] = p;
    tmax = tmin = t;  pmax = pmin = p;
    firstRead = false;
  }

  tmax = max(tmax, t);   tmin = min(tmin, t);
  pmax = max(pmax, p);   pmin = min(pmin, p);

  static uint32_t lastSlot = millis();
  if (millis() - lastSlot >= SLOT_MS) {      // store one sample every 10 min
    lastSlot = millis();
    hist[slot] = p;
    slot = (slot + 1) % SLOTS;
  }

  drop = hist[slot] - p;                     // hist[slot] = oldest sample (~3 h ago)

  char old = state;
  if      (drop >= STORM_DROP) state = 'W';
  else if (drop >= RAIN_DROP)  state = 'R';
  else if (drop <= -RAIN_DROP) state = 'I';
  else                         state = 'S';
  if (state != old && (state == 'R' || state == 'W')) page = 2;   // jump to forecast
}

const char* stateText() {
  switch (state) {
    case 'W': return "STORM WARNING";
    case 'R': return "RAIN LIKELY";
    case 'I': return "IMPROVING";
    default:  return "STABLE";
  }
}

/* ---------- OLED pages ---------- */
void drawPage() {
  if (!oledOK) return;
  oled.clearDisplay();
  oled.setTextColor(SSD1306_WHITE);
  oled.setTextSize(1);
  oled.setCursor(0, 0);

  if (page == 0) {                           // live readings
    oled.println("WEATHER  - LIVE");
    oled.println();
    oled.printf("Temp : %.1f C\n\n", t);
    oled.printf("Press: %.1f hPa\n\n", p);
    oled.printf("Alt  : %.0f m\n", a);
  }
  else if (page == 1) {                      // max / min
    oled.println("MAX / MIN");
    oled.println();
    oled.printf("Temp  max %.1f C\n", tmax);
    oled.printf("      min %.1f C\n\n", tmin);
    oled.printf("Press max %.1f\n", pmax);
    oled.printf("      min %.1f hPa\n", pmin);
  }
  else {                                     // forecast
    oled.println("FORECAST");
    oled.println();
    oled.printf("dP (3h): %+.1f hPa\n", -drop);
    oled.println();
    oled.setTextSize(state == 'W' ? 1 : 2);
    oled.println(stateText());
  }
  oled.display();
}

/* ---------- setup / loop ---------- */
void setup() {
  Serial.begin(9600);                        // USB -> PC -> Proteus 8051
  Serial2.begin(9600, SERIAL_8N1, RX_UNUSED, TX_TO_8051);
  pinMode(DEMO_PIN, INPUT_PULLUP);
  Wire.begin(SDA_PIN, SCL_PIN);

  i2cScan();                                 // expect 0x3C (OLED) and 0x77 (BMP180)
  bmpOK  = bmp.begin();
  oledOK = oled.begin(SSD1306_SWITCHCAPVCC, OLED_ADDR);
  Serial.println(bmpOK  ? "BMP180 OK" : "BMP180 NOT FOUND");
  Serial.println(oledOK ? "OLED OK"   : "OLED NOT FOUND");

  if (oledOK) {
    oled.clearDisplay();
    oled.setTextColor(SSD1306_WHITE);
    oled.setTextSize(1);
    oled.setCursor(0, 0);
    oled.println("Weather Station");
    oled.println("Starting...");
    oled.display();
  }
}

void loop() {
  static uint32_t lastRead = 0, lastPage = 0;

  if (millis() - lastRead >= READ_MS) {
    lastRead = millis();
    if (!bmpOK) { bmpOK = bmp.begin(); return; }   // no data -> 8051 blinks LED fast

    updateWeather();
    Serial.printf("#%c\n", state);          // to simulated 8051 (via USB)
    Serial2.printf("#%c\n", state);         // to a real 8051 on GPIO 25
    Serial.printf("T=%.1f P=%.1f A=%.0f drop=%.1f state=%c\n",
                  t, p, a, drop, state);
    drawPage();
  }

  if (!firstRead && millis() - lastPage >= PAGE_MS) {
    lastPage = millis();
    if (state == 'R' || state == 'W') page = (page == 2) ? 0 : 2;  // live <-> forecast
    else                              page = (page + 1) % 3;
    drawPage();
  }
}