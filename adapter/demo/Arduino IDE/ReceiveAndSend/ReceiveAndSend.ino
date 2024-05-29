
#include <Arduino.h>


#include "PinDefinitionsAndMore.h"

#define IRSND_IR_FREQUENCY          38000

#define IRMP_PROTOCOL_NAMES              1 // Enable protocol number mapping to protocol strings - needs some program memory ~ 420 bytes here
#define IRMP_USE_COMPLETE_CALLBACK       1 // Enable callback functionality
#define NO_LED_FEEDBACK_CODE   // Activate this if you want to suppress LED feedback or if you do not have a LED. This saves 14 bytes code and 2 clock cycles per interrupt.


#define F_INTERRUPTS                     20000 // Instead of default 15000 to support LEGO + RCMM protocols

#include <irmpSelectAllProtocols.h>
#include <irsndSelectAllProtocols.h>


#define USE_ONE_TIMER_FOR_IRMP_AND_IRSND // otherwise we get an error on AVR platform: redefinition of 'void __vector_8()

#include <irmp.hpp>
#include <irsnd.hpp>

IRMP_DATA irmp_data;
IRMP_DATA irsnd_data;

int buttonPin = 36;


void handleReceivedIRData();

bool volatile sIRMPDataAvailable = false;

void setup() 
{
  Serial.begin(115200);
  pinMode(buttonPin, INPUT_PULLUP);

  delay(500);
  
  Serial.println(F("START " __FILE__ " from " __DATE__ "\r\nUsing library version " VERSION_IRMP));

  irmp_init();
  irmp_register_complete_callback_function(&handleReceivedIRData);

  Serial.print(F("Ready to receive IR signals of protocols: "));
  irmp_print_active_protocols(&Serial);
  Serial.println(F("at pin " STR(IRMP_INPUT_PIN)));

  Serial.print(F("Send sample frequency="));
  Serial.print(F_INTERRUPTS);
  Serial.println(F(" Hz"));

  irsnd_init();
  irmp_irsnd_LEDFeedback(true); // Enable send signal feedback at LED_BUILTIN

  Serial.println(F("Send IR signals at pin " STR(IRSND_OUTPUT_PIN)));
  delay(1000);
}





void loop() 
{ 
    irsnd_init();
    irsnd_data.protocol = IRMP_NEC_PROTOCOL;
    irsnd_data.address = 0xEF00;
    irsnd_data.command = 0x3;
    irsnd_data.flags = 4;
    
    Serial.println(irsnd_data.protocol);

    delay(3000);
    irmp_result_print(&irsnd_data);
    irsnd_send_data(&irsnd_data, true);
  if (sIRMPDataAvailable)
  {
    sIRMPDataAvailable = false;

    irmp_init();
    irmp_result_print(&irmp_data);
    uint8_t sProtocol = irmp_data.protocol;
    uint8_t sAddress = irmp_data.address;
    uint8_t sCommand = irmp_data.command;
    uint8_t sFlags = irmp_data.flags;

    Serial.print("P=");
    irmp_print_protocol_name(&Serial, sProtocol);

    Serial.print(F(" A=0x"));
    Serial.print(irmp_data.address, HEX);
    Serial.print(F(" C=0x"));
    Serial.println(irmp_data.command, HEX);


    irsnd_init();
    irsnd_data.protocol = IRMP_NEC_PROTOCOL;
    irsnd_data.address = 0xEF00;
    irsnd_data.command = 0x3;
    irsnd_data.flags = 4;
    
    Serial.println(irsnd_data.protocol);

    delay(3000);
    irmp_result_print(&irsnd_data);
    irsnd_send_data(&irsnd_data, true);
    if (buttonPin == 1)
    {
      irsnd_init();
      irmp_result_print(&irsnd_data);
      irsnd_send_data(&irsnd_data, true);
      delay(500);
    }
  }
}

void IRAM_ATTR handleReceivedIRData()
{
  irmp_get_data(&irmp_data);
  sIRMPDataAvailable = true;
}



















