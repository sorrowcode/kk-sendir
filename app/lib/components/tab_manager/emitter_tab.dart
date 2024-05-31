import 'dart:async';

import 'package:flutter/material.dart';

import 'package:flutter_blue_plus/flutter_blue_plus.dart';
// import 'package:get/get.dart';


import 'package:remote_control/components/device_item.dart';
import 'package:remote_control/data/led_stripe.dart';
import 'package:remote_control/pages/home_page.dart';

import '../ble_controller.dart';
import '../key_item.dart';


class EmitterTab extends StatefulWidget {
  const EmitterTab({super.key, required this.deviceItems});

  final List<DeviceItem> deviceItems;

  @override
  State<EmitterTab> createState() => _EmitterTabState();
}

class _EmitterTabState extends State<EmitterTab> {
  final List<KeyItem> _keys = LedStripe.keyList;
  final StreamController _streamController = BleController.isSendingController;
  Timer? addTimer;
  Timer? removeTimer;
  bool _isSending = false;

  void onTap({required int key, bool stream = true}) async {
    KeyItem? data;
    DeviceIdentifier remoteID = const DeviceIdentifier('none');

    for (DeviceItem item in widget.deviceItems) {
      if (item.uuid == MyHomePage.selectedDevice) {
        remoteID = item.remoteID;
      }
    }

    if (remoteID == const DeviceIdentifier('none')) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Please select a device"),));
      _isSending = false;
      throw Exception("No device selected");
    }

    for (KeyItem item in _keys) {
      if (item.key == key) {
        data = item;
      }
    }
    if (data == null) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("This key is not configured"),));
      _isSending = false;
      throw Exception("This key is not configured");
    }

    if (stream && !_isSending) {
      _isSending = true;
      BleController().writeToDevice(BluetoothDevice(remoteId: remoteID), data, stream);
      await Future.delayed(const Duration(milliseconds: 400));
      _isSending = false;

    }else if (!stream) {
      BleController().writeToDevice(BluetoothDevice(remoteId: remoteID), data, stream);
    }
  }

  /*
  Future<void> delayedPress(bool keyPressed) async {
    await Future.delayed(const Duration(seconds: 5));
    keyPressed = false;
  }
  */

  void _onLongPressRemove(bool start) {
    if (start) {
      setState(() {
        addTimer ??= Timer.periodic(const Duration(milliseconds: 200), (timer) {
            onTap(key: 1, stream: false);
        });
        _streamController.add(true);
      });
    } else {
      setState(() {
        if (addTimer!= null) {
          addTimer!.cancel();
          addTimer = null;
          _streamController.add(false);
        }
      });
    }
  }

  void _onLongPressAdd(bool start) {
    if (start) {
      setState(() {
        removeTimer ??= Timer.periodic(const Duration(milliseconds: 200), (timer) {
            onTap(key: 0, stream: false);
        });
        _streamController.add(true);
      });
    } else {
      setState(() {
        if (removeTimer!= null) {
          removeTimer!.cancel();
          removeTimer = null;
          _streamController.add(false);
        }
      });
    }
  }

  final TextStyle _onWhite = const TextStyle(color: Colors.black, fontSize: 20);

  final TextStyle _onMainButton = const TextStyle(color: Colors.white, fontSize: 20);
  final TextStyle _onActionButton = const TextStyle(color: Colors.white, fontSize: 15);
  final TextStyle _onButton = const TextStyle(color: Colors.white, fontSize: 12);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
      child: Column(
        children: [
          Expanded(
            child: GridView.count(
              crossAxisCount: 4,
              children: [
                GestureDetector(onLongPressStart: (details) => _onLongPressAdd(true), onLongPressEnd: (details) => _onLongPressAdd(false), child: ElevatedButton(onPressed: () => onTap(key: 0), child: const Icon(Icons.add, color: Colors.white, size: 30))),
                GestureDetector(onLongPressStart: (details) => _onLongPressRemove(true), onLongPressEnd: (details) => _onLongPressRemove(false), child: ElevatedButton(onPressed: () => onTap(key: 1), child: const Icon(Icons.remove, color: Colors.white, size: 30))),
                ElevatedButton(onPressed: () => onTap(key: 2), child: Text("OFF", style: _onMainButton)),
                ElevatedButton(onPressed: () => onTap(key: 3), child: Text("ON", style: _onMainButton)),

                ElevatedButton(onPressed: () => onTap(key: 4), style: ButtonStyle(backgroundColor: WidgetStatePropertyAll(Colors.red[900])), child: Text("Red", style: _onMainButton)),
                ElevatedButton(onPressed: () => onTap(key: 5), style: ButtonStyle(backgroundColor: WidgetStatePropertyAll(Colors.green[900])), child: Text("Green", style: _onMainButton)),
                ElevatedButton(onPressed: () => onTap(key: 6), style: ButtonStyle(backgroundColor: WidgetStatePropertyAll(Colors.blue[900])), child: Text("Blue", style: _onMainButton)),
                ElevatedButton(onPressed: () => onTap(key: 7), style: const ButtonStyle(backgroundColor: WidgetStatePropertyAll(Colors.white)), child: Text("White", style: _onWhite,)),

                ElevatedButton(onPressed: () => onTap(key: 8), style: ButtonStyle(backgroundColor: WidgetStatePropertyAll(Colors.deepOrange[900])), child: Text("Deep Orange", style: _onButton)),
                ElevatedButton(onPressed: () => onTap(key: 9), style: ButtonStyle(backgroundColor: WidgetStatePropertyAll(Colors.green[700])), child: Text("Light Green", style: _onButton)),
                ElevatedButton(onPressed: () => onTap(key: 10), style: ButtonStyle(backgroundColor: WidgetStatePropertyAll(Colors.blue[700])), child: Text("Light Blue", style: _onButton)),
                ElevatedButton(onPressed: () => onTap(key: 11), child: Text("Flash", style: _onActionButton)),

                ElevatedButton(onPressed: () => onTap(key: 12), style: ButtonStyle(backgroundColor: WidgetStatePropertyAll(Colors.deepOrange[700])), child: Text("Orange", style: _onButton)),
                ElevatedButton(onPressed: () => onTap(key: 13), style: ButtonStyle(backgroundColor: WidgetStatePropertyAll(Colors.teal[600])), child: Text("Teal", style: _onButton)),
                ElevatedButton(onPressed: () => onTap(key: 14), style: ButtonStyle(backgroundColor: WidgetStatePropertyAll(Colors.purple[900])), child: Text("Deep Purple", style: _onButton)),
                ElevatedButton(onPressed: () => onTap(key: 15), child: Text("Strobe", style: _onActionButton)),

                ElevatedButton(onPressed: () => onTap(key: 16), style: ButtonStyle(backgroundColor: WidgetStatePropertyAll(Colors.orange[600])), child: Text("Light Orange", style: _onButton)),
                ElevatedButton(onPressed: () => onTap(key: 17), style: ButtonStyle(backgroundColor: WidgetStatePropertyAll(Colors.cyan[700])), child: Text("Light Cyan", style: _onButton)),
                ElevatedButton(onPressed: () => onTap(key: 18), style: ButtonStyle(backgroundColor: WidgetStatePropertyAll(Colors.purple[700])), child: Text("Purple", style: _onButton)),
                ElevatedButton(onPressed: () => onTap(key: 19), child: Text("Fade", style: _onActionButton)),

                ElevatedButton(onPressed: () => onTap(key: 20), style: ButtonStyle(backgroundColor: WidgetStatePropertyAll(Colors.amber[300])), child: Text("Amber", style: _onButton)),
                ElevatedButton(onPressed: () => onTap(key: 21), style: ButtonStyle(backgroundColor: WidgetStatePropertyAll(Colors.cyan[900])), child: Text("Cyan", style: _onButton)),
                ElevatedButton(onPressed: () => onTap(key: 22), style: ButtonStyle(backgroundColor: WidgetStatePropertyAll(Colors.pink[400])), child: Text("Light Pink", style: _onButton)),
                ElevatedButton(onPressed: () => onTap(key: 23), child: Text("Smooth", style: _onActionButton)),
                
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