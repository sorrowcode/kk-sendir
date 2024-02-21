# kk-sendir

![architecture](./assets/architecture-sendir.png)

## Idea

Several smartphones with the `app` are able to communicate to the IR adapter.

## Devices

- https://irdroid.eu/product/usb-infrared-transceiver/ (IR)
- https://www.mouser.de/c/optoelectronics/infrared-data-communications/infrared-emitters/ (list of IR emitter)
- https://www.raspberrypi.com/products/raspberry-pi-pico/ (micro controller)
- LED for feedback

---

## Todo

- "language" of the IR receiver
- powercontrol?
- app
    - design
        - UI
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

### Functions
- Two modes:
  - Emitting-Mode
  - Receiving-Mode
- Creating different "Remotes" (Storing different key combinations for various devices)

### Architecture
