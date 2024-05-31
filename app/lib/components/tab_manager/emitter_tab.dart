import 'dart:async';

import 'package:flutter/material.dart';

import 'package:flutter_blue_plus/flutter_blue_plus.dart';
import 'package:remote_control/components/device_item.dart';
import 'package:remote_control/pages/home_page.dart';

import '../ble_controller.dart';
import '../key_item.dart';
import '../../data/keys.dart';


class EmitterTab extends StatefulWidget {
  const EmitterTab({super.key, required this.deviceItems});

  final List<DeviceItem> deviceItems;

  @override
  State<EmitterTab> createState() => _EmitterTabState();
}

class _EmitterTabState extends State<EmitterTab> {
  final List<KeyItem> _keys = KeyList.ledStripe;

  Timer? lighterTimer;
  Timer? darkerTimer;
  void onTap(int key) async {
    bool keyPressed = false;
    KeyItem? data;
    DeviceIdentifier remoteID = const DeviceIdentifier('none');

    for (DeviceItem item in widget.deviceItems) {
      if (item.uuid == MyHomePage.selectedDevice) {
        remoteID = item.remoteID;
      }
    }

    if (remoteID == const DeviceIdentifier('none')) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Please select a device"),));
      throw Exception("No device selected");
    }

    for (KeyItem item in _keys) {
      if (item.key == key) {
        data = item;
      }
    }
    if (data == null && keyPressed == false) {
      keyPressed = true;
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("This key is not configured"),));
      delayedPress(keyPressed);
      throw Exception("This key is not configured");
    } else {
      throw Exception("Wait 5s");
    }

    BleController().writeToDevice(BluetoothDevice(remoteId: remoteID), data);
  }

  Future<void> delayedPress(bool keyPressed) async {
    await Future.delayed(const Duration(seconds: 5));
    keyPressed = false;
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
      child: Column(
        children: [
          Expanded(
            child: GridView.count(
              crossAxisCount: 3,
              children: [
                ElevatedButton(
                    onPressed: () => onTap(0),
                    child: const Icon(Icons.power_settings_new)),
                ElevatedButton(onPressed: () => onTap(1), child: const Text("OFF")),
                ElevatedButton(onPressed: () => onTap(2), child: const Text("null")),
                ElevatedButton(onPressed: () => onTap(3), child: const Text("Red")),
                ElevatedButton(onPressed: () => onTap(4), child: const Text("Green")),
                ElevatedButton(onPressed: () => onTap(5), child: const Text("Blue")),
                ElevatedButton(onPressed: () => onTap(6), child: const Text("White")),
                ElevatedButton(onPressed: () => onTap(7), child: const Text("Flash")),
                ElevatedButton(onPressed: () => onTap(8), child: const Text("Strobe")),
                ElevatedButton(onPressed: () => onTap(9), child: const Text("Fade")),
                ElevatedButton(onPressed: () => onTap(10), child: const Text("Smooth")),
                ElevatedButton(onPressed: () => onTap(11), child: const Text("9")),
                GestureDetector(
                  onLongPressStart: (details) {
                    setState(() {
                      lighterTimer ??= Timer.periodic(const Duration(milliseconds: 100), (timer) {
                          onTap(12);
                      });
                    });
                  },
                  onLongPressEnd: (details) {
                    setState(() {
                      if (lighterTimer!= null) {
                        lighterTimer!.cancel();
                        lighterTimer = null;
                      }
                    });
                  },
                  child: ElevatedButton(onPressed: () => onTap(12), child: const Text("lighter"))
                  ),
                ElevatedButton(onPressed: () => onTap(13), child: const Text("0")),
                GestureDetector(
                  onLongPressStart: (details) {
                    setState(() {
                      darkerTimer ??= Timer.periodic(const Duration(milliseconds: 100), (timer) {
                          onTap(14);
                      });
                    });
                  },
                  onLongPressEnd: (details) {
                    setState(() {
                      if (darkerTimer!= null) {
                        darkerTimer!.cancel();
                        darkerTimer = null;
                      }
                    });
                  },
                  child: ElevatedButton(onPressed: () => onTap(14), child: const Text("darker"))
                  ),
                ElevatedButton(onPressed: () => onTap(15), child: const Icon(Icons.add)),
                ElevatedButton(onPressed: () => onTap(16), child: const Text("null")),
                ElevatedButton(onPressed: () => onTap(17), child: const Icon(Icons.add)),
                Icon(Icons.signal_cellular_null, color: Theme.of(context).colorScheme.primary,),
                ElevatedButton(onPressed: () => onTap(18), child: const Text("null")),
                Center(
                  child: Text(
                    "CH",
                    style: TextStyle(
                      color: Theme.of(context).colorScheme.primary,
                    ),
                  )
                ),
                ElevatedButton(
                    onPressed: () => onTap(19), child: const Icon(Icons.remove)),
                ElevatedButton(
                    onPressed: () => onTap(20), child: const Icon(Icons.volume_off)),
                ElevatedButton(
                    onPressed: () => onTap(21), child: const Icon(Icons.remove)),
                ElevatedButton(onPressed: () => onTap(22), child: const Text("null")),
                ElevatedButton(
                    onPressed: () => onTap(23), child: const Icon(Icons.arrow_upward)),
                ElevatedButton(onPressed: () => onTap(24), child: const Text("null")),
                ElevatedButton(
                    onPressed: () => onTap(25), child: const Icon(Icons.arrow_back)),
                ElevatedButton(onPressed: () => onTap(26), child: const Text("OK")),
                ElevatedButton(
                    onPressed: () => onTap(27), child: const Icon(Icons.arrow_forward)),
                ElevatedButton(onPressed: () => onTap(28), child: const Text("null")),
                ElevatedButton(
                    onPressed: () => onTap(29), 
                    child: const Icon(Icons.arrow_downward)
                    ),
                ElevatedButton(
                  onPressed: () => onTap(30), 
                  child: const Text("null")
                  ),
                /*
                ElevatedButton(
                    onPressed: () => onTap(0),
                    child: const Icon(Icons.power_settings_new)),
                ElevatedButton(onPressed: () => onTap(1), child: const Text("null")),
                ElevatedButton(onPressed: () => onTap(2), child: const Text("null")),
                ElevatedButton(onPressed: () => onTap(3), child: const Text("1")),
                ElevatedButton(onPressed: () => onTap(4), child: const Text("2")),
                ElevatedButton(onPressed: () => onTap(5), child: const Text("3")),
                ElevatedButton(onPressed: () => onTap(6), child: const Text("4")),
                ElevatedButton(onPressed: () => onTap(7), child: const Text("5")),
                ElevatedButton(onPressed: () => onTap(8), child: const Text("6")),
                ElevatedButton(onPressed: () => onTap(9), child: const Text("7")),
                ElevatedButton(onPressed: () => onTap(10), child: const Text("8")),
                ElevatedButton(onPressed: () => onTap(11), child: const Text("9")),
                ElevatedButton(onPressed: () => onTap(12), child: const Text("null")),
                ElevatedButton(onPressed: () => onTap(13), child: const Text("0")),
                ElevatedButton(onPressed: () => onTap(14), child: const Text("null")),
                ElevatedButton(onPressed: () => onTap(15), child: const Icon(Icons.add)),
                ElevatedButton(onPressed: () => onTap(16), child: const Text("null")),
                ElevatedButton(onPressed: () => onTap(17), child: const Icon(Icons.add)),
                Icon(Icons.signal_cellular_null, color: Theme.of(context).colorScheme.primary,),
                ElevatedButton(onPressed: () => onTap(18), child: const Text("null")),
                Center(
                  child: Text(
                    "CH",
                    style: TextStyle(
                      color: Theme.of(context).colorScheme.primary,
                    ),
                  )
                ),
                ElevatedButton(
                    onPressed: () => onTap(19), child: const Icon(Icons.remove)),
                ElevatedButton(
                    onPressed: () => onTap(20), child: const Icon(Icons.volume_off)),
                ElevatedButton(
                    onPressed: () => onTap(21), child: const Icon(Icons.remove)),
                ElevatedButton(onPressed: () => onTap(22), child: const Text("null")),
                ElevatedButton(
                    onPressed: () => onTap(23), child: const Icon(Icons.arrow_upward)),
                ElevatedButton(onPressed: () => onTap(24), child: const Text("null")),
                ElevatedButton(
                    onPressed: () => onTap(25), child: const Icon(Icons.arrow_back)),
                ElevatedButton(onPressed: () => onTap(26), child: const Text("OK")),
                ElevatedButton(
                    onPressed: () => onTap(27), child: const Icon(Icons.arrow_forward)),
                ElevatedButton(onPressed: () => onTap(28), child: const Text("null")),
                ElevatedButton(
                    onPressed: () => onTap(29), 
                    child: const Icon(Icons.arrow_downward)
                    ),
                ElevatedButton(
                  onPressed: () => onTap(30), 
                  child: const Text("null")
                  ),

                  */
              ],
            ),
          ),
        ],
      ),
    );
  }
}