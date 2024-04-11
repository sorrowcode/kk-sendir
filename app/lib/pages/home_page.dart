// ignore_for_file: must_be_immutable
import 'package:flutter/material.dart';

import 'package:Remote_Control/components/custom_navigation_bar.dart';
import 'package:Remote_Control/components/device_item.dart';
import 'package:Remote_Control/components/tab_manager/emitter_tab.dart';
import 'package:Remote_Control/components/tab_manager/receiver_tab.dart';
import 'package:Remote_Control/components/custom_fab.dart';
import 'package:Remote_Control/components/custom_drawer.dart';

var selectedDevice;
var selectedDeviceName;

class MyHomePage extends StatefulWidget {
  MyHomePage({super.key});

  String title = "Choose a device";
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  TextEditingController textController = TextEditingController();

  final List<Widget> _navigationOptions = <Widget>[
    const EmitterTab(),
    const ReceiverTab(),
  ];

  final List<DeviceItem> _deviceItems = [];

  int _selectedIndex = 0;

  double _edgeWidth = MediaQueryData.fromView(WidgetsBinding.instance.window).size.width / 2;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  String title(var title) {
    String newTitle = 'Select a device';
      if (title != null) {
        newTitle = title;
      }
    return newTitle;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      appBar: AppBar(
        title: Text(title(selectedDeviceName)),
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
      drawerEdgeDragWidth: _edgeWidth,
      endDrawerEnableOpenDragGesture: false,
      onDrawerChanged: (isOpened) {
        setState(() {
          
        });
      },
      body: GestureDetector(
        onTap: () {
          print('Tapped');
        },
        onHorizontalDragEnd: (details) {
          print(details.primaryVelocity.toString());
          setState(() {
            if (details.primaryVelocity !> 0) {
              _edgeWidth = MediaQuery.of(context).size.width / 2;
              _selectedIndex = 0;
            print('page backward');
          }else if (details.primaryVelocity !< 0 || details.primaryVelocity == 0) {
              _edgeWidth = 40;
              _selectedIndex = 1;
            print('page forward');
          }
          });
        },
        child: Scaffold(
          backgroundColor: Theme.of(context).colorScheme.background,
          body: Center(
                  child: _navigationOptions.elementAt(_selectedIndex)
                ),
        ),
      ),
      floatingActionButton: CustomFAB(deviceItems: _deviceItems),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: CustomNavigationBar(
        selectedIndex: _selectedIndex,
        onItemTapped: _onItemTapped,
      ),
    );
  }
}
