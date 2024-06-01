import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_blue_plus/flutter_blue_plus.dart';
import 'package:get/get.dart';
import 'package:permission_handler/permission_handler.dart';
import 'items/key_item.dart';
import 'items/credential.dart';

class BleController extends GetxController {
  static List<BluetoothDevice> connectedDevices =
      FlutterBluePlus.connectedDevices;

  static StreamController<bool> isSendingController =
      StreamController<bool>.broadcast();

  static StreamController<bool> isConnectedController = StreamController<bool>.broadcast();

  static bool isSending = false;
  static Stream<bool> get isSendingStream => Stream.value(isSending);

  static const int duration = 30;
// This Function will help users to scan near by BLE devices and get the list of Bluetooth devices.
  Future scanDevices() async {
    if (await Permission.bluetoothScan.request().isGranted) {
      if (await Permission.bluetoothConnect.request().isGranted) {
        await FlutterBluePlus.startScan(
            timeout: const Duration(seconds: duration),
            withKeywords: ["SendIR"]);
      }
    }
  }

  void stopScan() {
    FlutterBluePlus.stopScan();
  }

// This function will help user to connect to BLE devices.
  Future<void> connectToDevice(BluetoothDevice device, BuildContext widgetContext, String name) async {
    int connectionState = 0;
    showDialog(
      context: widgetContext, 
      builder: (dialogContext) {
        return AlertDialog(
          title: Text("Connecting to ${name == "" ? "Device" : name}"),
          content: StatefulBuilder(
            builder: (stflContext, setState) {
              while (stflContext.mounted) {
                Widget CustomText() {
                  if (connectionState == 2) {
                    return const Text("Connected!");
                  } else if (connectionState == 3) {
                    return const CircularProgressIndicator();
                  } else {
                    return const Text("Device not reachable");
                  }
                }
                Future connectToDevice() async {
                  if (connectionState == 0) {
                    try {
                      connectionState = 3;
                      await device.connect(timeout: const Duration(seconds: 30));
                    } catch (e) {
                      if (stflContext.mounted && dialogContext.mounted) {
                        setState(() {
                        connectionState = 1;
                      });
                      }
                    }
                  }
                }
                bool isConnecting() {
                  if (connectionState == 3) {
                    return true;
                  } else{
                    return false;
                  }
                }
                device.connectionState.listen((state) {
                  if (state == BluetoothConnectionState.connected && stflContext.mounted && dialogContext.mounted) {
                    setState(() {
                      connectionState = 2;
                    });
                  } else if (!stflContext.mounted && !dialogContext.mounted) {
                    return;
                  }
                });
                connectToDevice();
                return Column(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[

                    Padding(
                      padding: const EdgeInsets.all(12),
                      child: CustomText(),
                    ),

                    ElevatedButton(
                      onPressed: () {
                        setState(() {
                          Navigator.of(dialogContext).pop();
                        });
                      },
                      child: isConnecting() ? const Text("Cancel") : const Text("OK"),
                    ),
                  ]
                );
              };
              Navigator.of(dialogContext).pop();
              throw Exception("not mounted");
            }
          )
        );
      }
    );
    /*
    device.connectionState.listen((isConnected) {
      if (isConnected == BluetoothConnectionState.connected) {
        print("Connected to Device: $device.platformName");
      }else if (isConnected == BluetoothConnectionState.disconnected) {
        print("Disconnected from Device");
      }else {
        print("Connecting");
      }
    });
    */
  }

  Future<void> disconnectFromAll(
      bool except, BluetoothDevice selectedDevice) async {
    List<BluetoothDevice> devices = FlutterBluePlus.connectedDevices;
    for (BluetoothDevice device in devices) {
      if (except && device != selectedDevice) {
        await device.disconnect();
      } else {
        await device.disconnect();
      }
    }
  }

  Future<void> disconnectFromDevice(BluetoothDevice device) async {
    await device.disconnect();
  }

  Future<void> writeToDevice(
      BluetoothDevice device, KeyItem data, bool stream) async {
    stream == true ? isSendingController.add(true) : null;
    List<BluetoothService> services = await device.discoverServices();
    for (BluetoothService s in services) {
      var characteristics = s.characteristics;
      for (BluetoothCharacteristic c in characteristics) {
        if (c.properties.write) {
          // c.write(utf8.encode(data.protocol.toString()));
          // c.write(utf8.encode(data.address.toString()));

          c.write([data.command]);

          // c.write(utf8.encode(data.flags.toString()));
          // print(data.address.toUnsigned(16));
          // print(data.address);
        }
      }
    }
    stream == true ? isSendingController.add(false) : null;
  }

  Future<void> writeCredsToDevice(
      BluetoothDevice device, List<Credential> creds) async {
    List<BluetoothService> services = await device.discoverServices();
    for (BluetoothService s in services) {
      var characteristics = s.characteristics;
      for (BluetoothCharacteristic c in characteristics) {
        if (c.properties.write) {
          for (Credential cred in creds) {
            c.write(utf8.encode(cred.name));
            c.write(utf8.encode(cred.value));
          }
          /*
            c.write(utf8.encode('SSID'));
            c.write(utf8.encode('BachGarten'));
            c.write(utf8.encode('BSSID'));
            c.write(utf8.encode('none'));
            c.write(utf8.encode('Password'));
            c.write(utf8.encode('23434'));
            
            */
        }
      }
      BleController.isSending = false;
    }

    services.clear();
    /*
    List<BluetoothService> services = await device.discoverServices();
    for (BluetoothService s in services) {
      var characteristics = s.characteristics;
      for(BluetoothCharacteristic c in characteristics) {
        if (c.properties.read) {
          List<int> value = await c.read();
          print(value);
        }
      }
    }
    services.forEach((service) async {
      var characteristics = service.characteristics;
      for(BluetoothCharacteristic c in characteristics) {
        if (c.properties.read) {
          List<int> value = await c.read();
          print(value);
        }
      }
    });
    */
  }

  Stream<List<ScanResult>> get scanResults => FlutterBluePlus.scanResults;
}
