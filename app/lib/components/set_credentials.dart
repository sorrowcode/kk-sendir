import 'dart:async';

import 'package:flutter/material.dart';

//import 'package:flutter_blue_plus/flutter_blue_plus.dart';
import 'package:network_info_plus/network_info_plus.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:passwordfield/passwordfield.dart';
import 'package:remote_control/components/custom_dialog.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_blue_plus/flutter_blue_plus.dart';


//import '../pages/home_page.dart';
import 'ble_controller.dart';
import 'credential.dart';
import 'device_item.dart';

class SetCredentialsScreen extends StatefulWidget {
  const SetCredentialsScreen({
    super.key,
    required this.device,
    required this.deviceItems,
    required this.onTap,
    required this.selMode,
    required this.remoteID,
    });
  final BluetoothDevice device;
  final List<DeviceItem> deviceItems;
  final void Function(String, DeviceIdentifier) onTap;
  final int selMode;
  final DeviceIdentifier remoteID;

  @override
  State<SetCredentialsScreen> createState() => _SetCredentialsScreenState();
}

class _SetCredentialsScreenState extends State<SetCredentialsScreen> {
  String? wifiName;
  String? wifiBSSID;
  String wifiPassword = 'none';

  late List<Credential> credentials;

  late final SharedPreferences prefs;

  Future<void> createInstance() async {
     prefs = await SharedPreferences.getInstance();
  }
  Future<void> writePrefs(List<Credential> preferences) async {
    for (Credential val in preferences) {
      await prefs.setString(val.name, val.value);
    }
  }

  Future<void> writeBle(List<Credential> preferences) async {
    if (widget.device.isConnected == true) {
      BleController().writeCredsToDevice(widget.device, preferences);
    }
  }


  @override
  void initState() {
    super.initState();
    setNetwork();
    createInstance();
  }
  Future<void> setNetwork() async {
    final info = NetworkInfo();
    var locationStatus = await Permission.location.status;
    if (locationStatus.isDenied) {
      await Permission.locationWhenInUse.request();
    }
    if (await Permission.location.isRestricted) {
      openAppSettings();
    }

    if (await Permission.location.isGranted) {
      wifiName = await info.getWifiName();
      wifiBSSID = await info.getWifiBSSID();
       credentials = [
                  Credential(name: "SSID", value: wifiName!), 
                  Credential(name: "BSSID", value: wifiBSSID!),
                  ];
      setState(() {});
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Enter your Wifi credentials'),
        elevation: 4,
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Flex(
          direction: Axis.vertical,
          children: [
            wifiName == null ? const Padding(
                padding: EdgeInsets.all(8.0),
                child: Text('No Wifi connected'),
              )
              : Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text('Wifi name: $wifiName'),
              ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: PasswordField(
                passwordConstraint: r'^(?!\s)',
                passwordDecoration: PasswordDecoration(),
                hintText: "Enter the password for your WiFi",
                border: PasswordBorder(
                  border: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Colors.blue.shade100,
                    ),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Colors.blue.shade100,
                    ),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  focusedErrorBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide(
                      width: 2, 
                      color: Colors.red.shade200
                      ),
                  ),
                ),
                onChanged: (p0) => wifiPassword = p0,
                onSubmit: (p0) => wifiPassword = p0,
              ),
            ),
            const Expanded(
              child: SizedBox()
            ),
            ElevatedButton(
              onPressed: () {
                writePrefs(credentials);
                writeBle([
                  Credential(name: "SSID", value: wifiName!),
                  Credential(name: "BSSID", value: wifiBSSID!),
                  Credential(name: "PASSWORD", value: wifiPassword),
                  ]);
                Navigator.of(context).pop();
                showDialog<String>(
                  context: context,
                  builder: (BuildContext context) => CustomDialog(
                    deviceItems: widget.deviceItems,
                    onTap: widget.onTap,
                    selMode: widget.selMode,
                    remoteID: widget.remoteID,
                  )
                );
                setState(() {});
              },
              child: const Text("Confirm"),
            )
          ],
        )
      ),
    );
  }
}