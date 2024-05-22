import 'package:flutter_blue_plus/flutter_blue_plus.dart';
import 'package:get/get.dart';
import 'package:permission_handler/permission_handler.dart';

class BleController extends GetxController{  
// This Function will help users to scan near by BLE devices and get the list of Bluetooth devices.
  Future scanDevices() async{
    if(await Permission.bluetoothScan.request().isGranted){
      if(await Permission.bluetoothConnect.request().isGranted){
        await FlutterBluePlus.startScan(timeout: const Duration(seconds: 30), withKeywords: ["SendIR"]);
      }
    }
  }

  Future stopScan() async {
    await FlutterBluePlus.stopScan();
  }

// This function will help user to connect to BLE devices.
 Future<void> connectToDevice(BluetoothDevice device)async {
    await device.connect(timeout: const Duration(seconds: 30));

    device.connectionState.listen((isConnected) {
      if (isConnected == BluetoothConnectionState.connected) {
        print("Connected to Device: $device.platformName");
      }else if (isConnected == BluetoothConnectionState.disconnected) {
        print("Disconnected from Device");
      }else {
        print("Connecting");
      }
    });

 }

  Stream<List<ScanResult>> get scanResults => FlutterBluePlus.scanResults;

}