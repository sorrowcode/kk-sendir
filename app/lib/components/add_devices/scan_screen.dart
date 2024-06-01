import 'package:flutter/material.dart';
import 'dart:async';

import 'package:flutter_blue_plus/flutter_blue_plus.dart';
import 'package:get/get.dart';
//import 'package:remote_control/components/set_credentials.dart';

import '../items/device_item.dart';
import '../ble_controller.dart';
import '../../pages/home_page.dart';
import '../custom_dialog.dart';

class ScanScreen extends StatefulWidget {
  const ScanScreen({
    super.key,
    required this.deviceItems,
    required this.onTap,
    required this.selMode,
  });

  final List<DeviceItem> deviceItems;
  final void Function(String, DeviceIdentifier) onTap;
  final int selMode;

  @override
  State<ScanScreen> createState() => _ScanScreenState();
}

class _ScanScreenState extends State<ScanScreen> {
  bool isScanning = false;

  Future scanning() async {
    while (mounted) {
      if (!isScanning) {
        setState(() {
          isScanning = true;
        });
        await Future.delayed(const Duration(seconds: BleController.duration));
        if (mounted) {
          setState(() {
            isScanning = false;
          });
        } else {
          break;
        }
      } else {
        await Future.delayed(const Duration(seconds: BleController.duration));
        if (mounted) {
          setState(() {
            isScanning = false;
          });
        } else {
          break;
        }
      }
    }
  }

  @override
  void initState() {
    super.initState();

    BleController().scanDevices();
    scanning();
  }

  @override
  void dispose() {
    BleController().stopScan();
    scanning();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).appBarTheme.backgroundColor,
        leading: IconButton(
          onPressed: () {
            Navigator.of(context).pop(MaterialPageRoute(
              builder: (context) => const MyHomePage(),
            ));
          },
          icon: const Icon(Icons.arrow_back),
        ),
        title: const Text('Add a new Device'),
        centerTitle: true,
      ),
      body: GetBuilder<BleController>(
        init: BleController(),
        builder: (BleController controller) {
          return StreamBuilder<List<ScanResult>>(
              stream: controller.scanResults,
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return Column(children: [
                    Padding(
                      padding: const EdgeInsets.all(8),
                      child: isScanning == true
                          ? const Text('Scanning for devices...')
                          : ElevatedButton(
                              onPressed: () async {
                                controller.stopScan();
                                controller.scanDevices();
                                scanning();
                              },
                              child: const Text("SCAN")),
                    ),
                    Expanded(
                      child: ListView.builder(
                          padding: const EdgeInsets.fromLTRB(5, 5, 5, 10),
                          shrinkWrap: true,
                          itemCount: snapshot.data!.length,
                          itemBuilder: (context, index) {
                            final data = snapshot.data![index];
                            return Card(
                              elevation: 2,
                              child: ListTile(
                                  title: Text(
                                    data.device.platformName == ""
                                        ? 'No DeviceName'
                                        : data.device.platformName,
                                  ),
                                  subtitle: Text(
                                    data.device.remoteId.str,
                                    style: TextStyle(
                                      color:
                                          Theme.of(context).colorScheme.primary,
                                    ),
                                  ),
                                  onTap: () {
                                    controller.connectToDevice(data.device);
                                    data.device.connectionState
                                        .listen((isConnected) {
                                      if (isConnected ==
                                          BluetoothConnectionState.connected) {
                                        Navigator.of(context).pop();
                                        showDialog<String>(
                                            context: context,
                                            builder: (BuildContext context) =>
                                                CustomDialog(
                                                  deviceItems:
                                                      widget.deviceItems,
                                                  onTap: widget.onTap,
                                                  selMode: widget.selMode,
                                                  remoteID:
                                                      data.device.remoteId,
                                                ));

                                        /*
                                            Navigator.of(context).push(MaterialPageRoute(
                                              builder: (context) => SetCredentialsScreen(device: data.device, deviceItems: widget.deviceItems, onTap: widget.onTap, selMode: widget.selMode,),
                                            ));
                                            */
                                        setState(() {});
                                      }
                                    });
                                  }),
                            );
                          }),
                    ),
                  ]);
                } else {
                  return const Center(
                    child: Text("No Device Found"),
                  );
                }
              });
        },
      ),
    );
  }
}
