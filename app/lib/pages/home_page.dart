import 'package:flutter/material.dart';
import 'package:flutter_blue_plus/flutter_blue_plus.dart';

import 'package:remote_control/components/custom_navigation_bar.dart';
import 'package:remote_control/components/device_item.dart';
import 'package:remote_control/components/tab_manager/emitter_tab.dart';
import 'package:remote_control/components/tab_manager/receiver_tab.dart';
import 'package:remote_control/components/custom_fab.dart';
import 'package:remote_control/components/custom_drawer.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});


  static String selectedDevice = "0";
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  static final List<DeviceItem> _deviceItems = [];

  int _selectedIndex = 0;

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
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.green, // inner circle color
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
