import 'dart:convert';

import 'package:flutter_blue_plus/flutter_blue_plus.dart';
import 'package:get/get.dart';
import 'package:permission_handler/permission_handler.dart';
import 'key_item.dart';
import 'credential.dart';

class BleController extends GetxController {
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
  Future<void> connectToDevice(BluetoothDevice device) async {
    await device.connect(timeout: const Duration(seconds: 30));
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

  Future<void> disconnectFromAll({required bool except, required BluetoothDevice selectedDevice}) async {
    List<BluetoothDevice> devices = FlutterBluePlus.connectedDevices;
    for (BluetoothDevice device in devices) {
      if (except && device != selectedDevice) {
        await device.disconnect();
      }else {
        await device.disconnect();
      }
    }
  }

  Future<void> disconnectFromDevice(BluetoothDevice device) async {
    await device.disconnect();
  }

  Future<void> writeToDevice(BluetoothDevice device, KeyItem data) async {
    List<BluetoothService> services = await device.discoverServices();
    for (BluetoothService s in services) {
      var characteristics = s.characteristics;
      for (BluetoothCharacteristic c in characteristics) {
        if (c.properties.write) {
          c.write(utf8.encode(data.protocol.toString()));
          c.write(utf8.encode(data.address.toString()));
          c.write(utf8.encode(data.command.toString()));
          c.write(utf8.encode(data.flags.toString()));
          print(data.address.toUnsigned(16));
          print(data.address);
        }
      }
    }
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
