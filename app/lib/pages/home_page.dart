import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_blue_plus/flutter_blue_plus.dart';
import 'package:remote_control/components/ble_controller.dart';

import 'package:remote_control/components/custom_navigation_bar.dart';
import 'package:remote_control/components/items/device_item.dart';
import 'package:remote_control/components/emitter_tab.dart';
import 'package:remote_control/components/receiver_tab.dart';
import 'package:remote_control/components/custom_fab.dart';
import 'package:remote_control/components/custom_drawer.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  static String selectedDevice = "0";
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  static final List<DeviceItem> _deviceItems = [
    DeviceItem(
        deviceName: "SendIR",
        remoteID: const DeviceIdentifier("FC:B4:67:F0:09:0A")),
  ];

  int _selectedIndex = 0;

  bool isSending = false;

  Stream<bool> isSendingSignals = BleController.isSendingController.stream;

  void _initializeDeviceItems() {
    setState(() {
      for (BluetoothDevice device in BleController.connectedDevices) {
        _deviceItems.add(DeviceItem(
          deviceName: device.platformName,
          remoteID: device.remoteId,
        ));
      }
    });
    List<DeviceIdentifier> bluetoothDevices = [];
    BleController().scanDevices();
    BleController().scanResults.listen((scanResults) {
      for (ScanResult result in scanResults) {
        bluetoothDevices.add(result.device.remoteId);
      }
      for (DeviceItem item in _deviceItems) {
        if (bluetoothDevices.contains(item.remoteID)) {
          setState(() {
            item.online = true;
          });
        } else {
          setState(() {
            item.online = false;
          });
        }
      }
    });
  }

  void _streamstart() {
    isSendingSignals.listen(
      (data) {
        setState(() {
          isSending = data;
        });
      },
    );
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  void _onAddDevice(String deviceName, DeviceIdentifier remoteID) {
    _deviceItems.add(DeviceItem(
      deviceName: deviceName,
      remoteID: remoteID,
    ));
  }

  String _setTitle() {
    late String selectedDeviceName;
    if (MyHomePage.selectedDevice == '0') {
      return 'Select Device';
    } else {
      for (DeviceItem items in _deviceItems) {
        if (items.uuid == MyHomePage.selectedDevice) {
          selectedDeviceName = items.deviceName;
        }
      }
      return selectedDeviceName;
    }
  }

  final _scaffoldKey = GlobalKey<ScaffoldState>();

  final List<Widget> _navigationOptions = <Widget>[
    EmitterTab(
      deviceItems: _deviceItems,
    ),
    const ReceiverTab(),
  ];


  @override
  void initState() {
    super.initState();
    _initializeDeviceItems();
    _streamstart();
  }

  @override
  void dispose() {
    BleController.isSendingController.close();
    BleController().stopScan();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: Theme.of(context).colorScheme.surface,
      appBar: AppBar(
        title: Text(_setTitle()),
        centerTitle: true,
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 30),
            child: Container(
              width: 28,
              height: 28,
              decoration: const BoxDecoration(
                color: Colors.black, // border color
                shape: BoxShape.circle,
              ),
              child: Padding(
                padding: const EdgeInsets.all(2), // border width
                child: Container(
                  // or ClipRRect if you need to clip the content
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: isSending == false
                        ? Theme.of(context).appBarTheme.backgroundColor
                        : Colors.green, // inner circle color
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
      drawer: CustomDrawer(
        deviceItems: _deviceItems,
      ),
      drawerEdgeDragWidth: 40,
      endDrawerEnableOpenDragGesture: false,
      onDrawerChanged: (isOpened) {
        setState(() {});
      },
      body: GestureDetector(
        onHorizontalDragEnd: (details) {
          setState(() {
            if (details.primaryVelocity! > 11 && _selectedIndex == 1) {
              _selectedIndex = 0;
            } else if (details.primaryVelocity! < -11 && _selectedIndex == 0) {
              _selectedIndex = 1;
            } else if (details.primaryVelocity! < -11 && _selectedIndex == 1) {
              _scaffoldKey.currentState!.openDrawer();
            } else if (details.primaryVelocity! > 11 && _selectedIndex == 0) {
              _scaffoldKey.currentState!.openDrawer();
            }
          });
        },
        child: Scaffold(
          backgroundColor: Theme.of(context).colorScheme.surface,
          body: _navigationOptions.elementAt(_selectedIndex),
        ),
      ),
      floatingActionButton: CustomFAB(
        deviceItems: _deviceItems,
        onTap: _onAddDevice,
        selMode: 0,
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: CustomNavigationBar(
        selectedIndex: _selectedIndex,
        onItemTapped: _onItemTapped,
      ),
    );
  }
}
