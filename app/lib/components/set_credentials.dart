import 'dart:async';

import 'package:flutter/material.dart';

import 'package:flutter_blue_plus/flutter_blue_plus.dart';
import 'package:network_info_plus/network_info_plus.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:passwordfield/passwordfield.dart';

import '../pages/home_page.dart';
import 'ble_controller.dart';

class SetCredentialsScreen extends StatefulWidget {
  const SetCredentialsScreen({
    super.key,
    });

  @override
  State<SetCredentialsScreen> createState() => _SetCredentialsScreenState();
}

class _SetCredentialsScreenState extends State<SetCredentialsScreen> {
  String? wifiName;
  String? wifiBSSID;

  @override
  void initState() {
    super.initState();
    setNetwork();
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
        child: Column(
          mainAxisSize: MainAxisSize.min,
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
              ),
            ),
          ],
        ),
      ),
    );
  }
}