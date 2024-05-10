#include <Wire.h>
#include <TFLI2C.h>
#include <Adafruit_Sensor.h>
#include <Adafruit_HMC5883_U.h>

TFLI2C tflI2C;
Adafruit_HMC5883_Unified mag = Adafruit_HMC5883_Unified(12345);

#define DO_PIN 14 // ESP32's pin GPIO14 connected to DO pin of the MQ2 sensor
int16_t tfDist; // variable to store distance in centimeter
int16_t tfAddr = TFL_DEF_ADR; // set the default I2C address or your custom value

void setup() {
  Serial.begin(115200); // initialize serial port at baud rate 115200
  Wire.begin();         // initialize wire library for I2C communication
  pinMode(DO_PIN, INPUT);

  Serial.println("warming up the MQ2 sensor");
  delay(20000); // wait for the MQ2 to warm up

  Wire.begin(); // Initialize I2C communication

  // Check if the magnetometer was found/initialized successfully.
  // If not, print an error message and halt execution.
  if (!mag.begin()) {
    Serial.println("Ooops, no HMC5883 detected ... Check your wiring!");
    while (1); // Infinite loop stops further code execution if sensor is not detected
  }
}

void loop() {
  int gasState = digitalRead(DO_PIN);

  if (gasState == HIGH) {
    Serial.println("The gas is NOT present");
  } else {
    Serial.println("The gas is present");
  }
    tflI2C.getData(tfDist, tfAddr); // get data from the TFluna sensor

    Serial.print("Distance: ");
    Serial.println(tfDist); // print the distance data to the serial monitor

    sensors_event_t event;  // variable to hold the sensor data
    mag.getEvent(&event);   // fetch the latest data from the magnetometer

    // Calculate the heading (angle) based on the magnetic field readings.
    // atan2() calculates the arc tangent of y/x that is in the range of -π to π.
    // We convert this angle from radians to degrees by multiplying by (180 / PI).
    float heading = (atan2(event.magnetic.y, event.magnetic.x) * 180) / PI;

    // Normalize the heading to be between 0 and 360 degrees
    if (heading < 0) {
      heading += 360;
    }

    // Print the calculated heading and raw magnetometer data to the Serial Monitor.
    Serial.print("Heading: ");
    Serial.println(heading); // Print the heading
    Serial.print("X: ");
    Serial.print(event.magnetic.x); // Magnetometer X value
    Serial.print(" Y: ");
    Serial.print(event.magnetic.y); // Magnetometer Y value
    Serial.print(" Z: ");
    Serial.println(event.magnetic.z); // Magnetometer Z value
  

  delay(500); // wait half a second (500 milliseconds) before the next loop iteration
}
