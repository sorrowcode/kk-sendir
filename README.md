# kk-sendir

![architecture](./assets/architecture-sendir.png)

## Idea

Several smartphones with the `app` are able to communicate to the IR adapter.

---

## Todo

- powercontrol?
- app
    - design
        - userinterface
        - gesture detector
        - animation controller
        - remote control
    - connection to back-end
    - architecture
- devices
    - micro controller
    - IR emitter/receiver/transceiver

## Programming IR-Transceiver
- Links:
    - https://learn.sparkfun.com/tutorials/ir-communication/all (Explanation of basics)
    - https://www.heise.de/hintergrund/Arduino-Multifunction-Shield-Infrarot-Fernbedienung-als-Steuerung-4844899.html (~)
      
    - https://github.com/Lime-Parallelogram/pyIR (Python Code for IR-Receiver: Repo)
    - https://mc.mikrocontroller.com/de/IR-Protokolle.php (Explanation of some protocols)
- Protocols:
    - meistbenutzte Protokolle nutzen
 
## Powercontrol
- Pi Pico power consumption: Idle= 0.16W
- Possible power sources:
  - Cable (5V)
  - Battery
    - AA Batteries (4xAA ca. 27Tage[Idle])
    - Battery-Pack
## App-Design


### Structure
- Various Screens (Modes/Remotes/Devices)
- Different Devices (for multiple Adapters)
- Remote design (img of a remote control with clickable keys)??

#### Possible Design:

<img src="./assets/App%20Structure.png" alt="drawing" width="750"/>

### Functions
- Two modes:
  - Emitting-Mode
  - Receiving-Mode
- Creating different "Remotes" (Storing different key combinations for various devices)

### Architecture

## Devices

- ESP32 with USB-C port (Akku?)
- (IR-Emitter)
- (IR-Receiver)
- LED
