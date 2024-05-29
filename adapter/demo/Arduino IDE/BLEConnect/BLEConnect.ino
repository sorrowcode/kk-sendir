#include <BLEDevice.h>
#include <BLEServer.h>
#include <BLEUtils.h>
#include <BLE2902.h>

// UUIDs für den Service und die Characteristics
#define SERVICE_UUID        "12345678-1234-1234-1234-123456789012"
#define CHARACTERISTIC_UUID "87654321-4321-4321-4321-210987654321"

// BLEServer und BLECharacteristic Objekte
BLEServer *pServer = NULL;
BLECharacteristic *pCharacteristic = NULL;
bool deviceConnected = false;
bool newData = false;
std::string rxValue;

// Callback Klasse für Server Ereignisse
class MyServerCallbacks : public BLEServerCallbacks {
  void onConnect(BLEServer* pServer) {
    deviceConnected = true;
  };

  void onDisconnect(BLEServer* pServer) {
    deviceConnected = false;
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
}

void loop() {
  if (deviceConnected && newData) {
    Serial.println("Received Value: ");
    for (int i = 0; i < rxValue.length(); i++)
      Serial.print(rxValue[i]);
    Serial.println();

    // Beispiel: sende eine Benachrichtigung zurück
    pCharacteristic->setValue("Message Received!");
    pCharacteristic->notify();

    // Setze newData zurück
    newData = false;
  }
}
