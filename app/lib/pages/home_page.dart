import 'package:app/components/custom_bottom_navigation_bar.dart';
import 'package:app/components/device_item.dart';
import 'package:app/components/tab_manager/emitter_tab.dart';
import 'package:app/components/tab_manager/receiver_tab.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:app/components/custom_drawer.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final List<Widget> _navigationOptions = <Widget>[
    const EmitterTab(),
    const ReceiverTab(),
  ];

  List<DeviceItem> _deviceItems = [];

  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text('HomeScreen'),
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
      drawer: CustomDrawer(deviceItems: _deviceItems),
      body: Center(
        child: _navigationOptions.elementAt(_selectedIndex),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          setState(() {
            _deviceItems.add(DeviceItem(deviceName: "deviceName"),);
            showDialog<String>(
                context: context,
                builder: (BuildContext context) => const Dialog(
                      child: Text("Add Device"),
                    ));
          });
        },
        //tooltip: 'Increment',
        shape: const CircleBorder(),
        elevation: 2,
        child: const Icon(Icons.add),
      ),
      bottomNavigationBar: CustomBottomNavigationBar(
        selectedIndex: _selectedIndex,
        onItemTapped: _onItemTapped,
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }
}
