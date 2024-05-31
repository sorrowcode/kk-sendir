// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'dart:ffi';

import 'package:flutter/material.dart';

import 'package:flutter_blue_plus/flutter_blue_plus.dart';
import 'package:remote_control/components/device_item.dart';
import 'package:remote_control/pages/home_page.dart';

//import 'package:remote_control/pages/home_page.dart';
import '../ble_controller.dart';

class EmitterTab extends StatefulWidget {
  const EmitterTab({
    super.key,
    required this.deviceItems
    });

  final List<DeviceItem> deviceItems;

  @override
  State<EmitterTab> createState() => _EmitterTabState();
}

class _EmitterTabState extends State<EmitterTab> {
  //final List<DropdownMenuEntry> _remotes = [
  //  DropdownMenuEntry(value: 0, label: 'Hello'),
  //  DropdownMenuEntry(value: 1, label: 'dadas'),
  //];

  //int _selectedRemote = 0;
  final List<Key> _keys = [
    Key(protocol: 2, address: 0xEF00.toUnsigned(16), command: 0x3, flags: 4, key: 0)
  ];


  void onTap(int key) {
    DeviceIdentifier remoteID = DeviceIdentifier('1234567890');
    for (DeviceItem item in widget.deviceItems) {
      if (item.uuid == selectedDevice) {
        remoteID = item.remoteID;
      }
    }
    if (remoteID == DeviceIdentifier('1234567890')) {
      throw Exception("No device selected");
    }
    BleController().writeToDevice(BluetoothDevice(remoteId: remoteID), _keys[key]);
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
      child: Column(
        children: [
          /*
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              DropdownMenu(
                initialSelection: _selectedRemote,
                onSelected: (value) {
                  setState(() {
                    _selectedRemote = value!;
                  });
                },
                dropdownMenuEntries: _remotes,
              ),
              
            ],
          ),
          */
          Expanded(
            child: GridView.count(
                  crossAxisCount: 3,
                  children: [
                    ElevatedButton(onPressed:() => onTap(0), child: Icon(Icons.power_settings_new)),
                    ElevatedButton(onPressed:() {}, child: Text("null")),
                    Icon(Icons.radio_button_unchecked),


                    ElevatedButton(onPressed:() {}, child: Text("1")),
                    ElevatedButton(onPressed:() {}, child: Text("2")),
                    ElevatedButton(onPressed:() {}, child: Text("3")),

                    ElevatedButton(onPressed:() {}, child: Text("4")),
                    ElevatedButton(onPressed:() {}, child: Text("5")),
                    ElevatedButton(onPressed:() {}, child: Text("6")),

                    ElevatedButton(onPressed:() {}, child: Text("7")),
                    ElevatedButton(onPressed:() {}, child: Text("8")),
                    ElevatedButton(onPressed:() {}, child: Text("9")),

                    ElevatedButton(onPressed:() {}, child: Text("null")),
                    ElevatedButton(onPressed:() {}, child: Text("0")),
                    ElevatedButton(onPressed:() {}, child: Text("null")),


                    ElevatedButton(onPressed:() {}, child: Icon(Icons.add)),
                    ElevatedButton(onPressed:() {}, child: Text("null")),
                    ElevatedButton(onPressed:() {}, child: Icon(Icons.add)),

                    ElevatedButton(onPressed: null, child: Icon(Icons.signal_cellular_null)),
                    ElevatedButton(onPressed:() {}, child: Text("null")),
                    ElevatedButton(onPressed: null, child: Text("CH")),

                    ElevatedButton(onPressed:() {}, child: Icon(Icons.remove)),
                    ElevatedButton(onPressed:() {}, child: Icon(Icons.volume_off)),
                    ElevatedButton(onPressed:() {}, child: Icon(Icons.remove)),


                    ElevatedButton(onPressed:() {}, child: Text("null")),
                    ElevatedButton(onPressed:() {}, child: Icon(Icons.arrow_upward)),
                    ElevatedButton(onPressed:() {}, child: Text("null")),

                    ElevatedButton(onPressed:() {}, child: Icon(Icons.arrow_back)),
                    ElevatedButton(onPressed:() {}, child: Text("OK")),
                    ElevatedButton(onPressed:() {}, child: Icon(Icons.arrow_forward)),

                    ElevatedButton(onPressed:() {}, child: Text("null")),
                    ElevatedButton(onPressed:() {}, child: Icon(Icons.arrow_downward)),
                    ElevatedButton(onPressed:() {}, child: Text("null")),


                  ],
                ),
          ),
        ],
      ),
    );
  }
}

class Key {
  const Key({
    required this.protocol,
    required this.address,
    required this.command,
    required this.flags,
    required this.key,
  });
  final int protocol;
  final int address;
  final int command;
  final int flags;
  final int key;
}