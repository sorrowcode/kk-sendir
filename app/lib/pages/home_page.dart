// ignore_for_file: must_be_immutable

import 'package:Remote_Control/components/custom_navigation_bar.dart';
import 'package:Remote_Control/components/device_item.dart';
import 'package:Remote_Control/components/tab_manager/emitter_tab.dart';
import 'package:Remote_Control/components/tab_manager/receiver_tab.dart';
import 'package:flutter/material.dart';
import 'package:Remote_Control/components/custom_drawer.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';

class MyHomePage extends StatefulWidget {
  MyHomePage({super.key});

  int selectedDevice = 0;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  TextEditingController textController = TextEditingController();
  
  late String deviceName;

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
      drawer: CustomDrawer(deviceItems: _deviceItems, selectedDevice: widget.selectedDevice,),
      body: Center(
        child: _navigationOptions.elementAt(_selectedIndex),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          setState(() {
            showDialog<String>(
                context: context,
                builder: (BuildContext context) => Dialog(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                Stack(
                                  alignment: AlignmentDirectional.bottomCenter,
                                  children: [ 
                                    IconButton(
                                      onPressed: () {
                                        setState(() {
                                          Navigator.of(context).pop();
                                        });
                                      },
                                      icon: const Icon(Icons.close),
                                    ),
                                    const Text('Close')
                                  ]
                                ),
                              ],
                            ),
                            TextField(
                              controller: textController,
                              maxLines: null,
                              inputFormatters: [
                                FilteringTextInputFormatter.deny(RegExp(r'^\s')),
                              ],
                              decoration: InputDecoration(
                                hintStyle: TextStyle(color: Theme.of(context).colorScheme.primary),
                                hintText: 'Enter a name for the device',
                              ),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            ElevatedButton.icon(
                              onPressed: () {
                                setState(() {
                                  deviceName = textController.text;
                                  if (deviceName == "") {}else {
                                    _deviceItems.add(DeviceItem(deviceName: deviceName));
                                    Navigator.of(context).pop();
                                    textController.clear();
                                  }
                                });
                                },
                              label: const Text('Add Device'),
                              icon: const Icon(Icons.add)
                            ),
                          ],
                        ),
                      ),
                    ));
          });
        },
        //tooltip: 'Increment',
        shape: const CircleBorder(),
        elevation: 2,
        child: const Icon(Icons.add),
      ),
      bottomNavigationBar: CustomNavigationBar(
        selectedIndex: _selectedIndex,
        onItemTapped: _onItemTapped,
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }
}
