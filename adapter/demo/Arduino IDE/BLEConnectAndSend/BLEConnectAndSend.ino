#include <BLEDevice.h>
#include <BLEServer.h>
#include <BLEUtils.h>
#include <BLE2902.h>

#include <Arduino.h>

#include "PinDefinitionsAndMore.h"

#define IRSND_IR_FREQUENCY          38000


#define IRSND_PROTOCOL_NAMES             1 
#define NO_LED_FEEDBACK_CODE   // Activate this if you want to suppress LED feedback or if you do not have a LED. This saves 14 bytes code and 2 clock cycles per interrupt.

#include <irsndSelectAllProtocols.h>

#include <irsnd.hpp>

IRMP_DATA irsnd_data;


// UUIDs für den Service und die Characteristics
#define SERVICE_UUID        "12345678-1234-1234-1234-123456789012"
#define CHARACTERISTIC_UUID "87654321-4321-4321-4321-210987654321"

// BLEServer und BLECharacteristic Objekte
BLEServer *pServer = NULL;
BLECharacteristic *pCharacteristic = NULL;
bool deviceConnected = false;
bool newData = false;
std::string rxValue;

uint8_t receivedValue = 0;

// Callback Klasse für Server Ereignisse
class MyServerCallbacks : public BLEServerCallbacks {
  void onConnect(BLEServer* pServer) {
    deviceConnected = true;
    Serial.println("Client connected!");
  };

  void onDisconnect(BLEServer* pServer) {
    deviceConnected = false;
    pServer->getAdvertising()->start();
    Serial.println("Waiting for a client connection...");
  }
};

// Callback Klasse für Characteristic Ereignisse
class MyCallbacks : public BLECharacteristicCallbacks {
  void onWrite(BLECharacteristic *pCharacteristic) {
    rxValue = pCharacteristic->getValue();
    newData = true;
  }
};

void setup() {
  Serial.begin(115200);

  // Initialisiere BLE
  BLEDevice::init("SendIR");

  // Erstelle den BLE Server
  pServer = BLEDevice::createServer();
  pServer->setCallbacks(new MyServerCallbacks());

  // Erstelle den BLE Service
  BLEService *pService = pServer->createService(SERVICE_UUID);

  // Erstelle die BLE Characteristic
  pCharacteristic = pService->createCharacteristic(
                      CHARACTERISTIC_UUID,
                      BLECharacteristic::PROPERTY_READ   |
                      BLECharacteristic::PROPERTY_WRITE  |
                      BLECharacteristic::PROPERTY_NOTIFY
                    );

  pCharacteristic->addDescriptor(new BLE2902());
  pCharacteristic->setCallbacks(new MyCallbacks());

  // Starte den Service
  pService->start();

  // Starte die Werbung
  pServer->getAdvertising()->start();
  Serial.println("Waiting for a client connection...");

  irsnd_init();
  irmp_irsnd_LEDFeedback(false);
}

void loop() {
  if (deviceConnected && newData) {
    if (rxValue.length() > 0) {
      // Den ersten Byte-Wert als uint8_t speichern
      receivedValue = static_cast<uint8_t>(rxValue[0]);

      // Ausgabe des empfangenen Werts
      Serial.print("Received Value: ");
      Serial.println(receivedValue);
    }

    Serial.println(receivedValue);

    irsnd_data.protocol = IRMP_NEC_PROTOCOL;
    irsnd_data.address = 0xEF00;
    irsnd_data.command = receivedValue;
    irsnd_data.flags = 3;

    irsnd_send_data(&irsnd_data, true);
    irsnd_data_print(&Serial, &irsnd_data);

    // Setze newData zurück
    newData = false;
  }
}
