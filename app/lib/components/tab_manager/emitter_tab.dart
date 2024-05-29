// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';

import 'package:flutter_blue_plus/flutter_blue_plus.dart';

//import 'package:remote_control/pages/home_page.dart';
import '../ble_controller.dart';

class EmitterTab extends StatefulWidget {
  const EmitterTab({super.key});

  @override
  State<EmitterTab> createState() => _EmitterTabState();
}

class _EmitterTabState extends State<EmitterTab> {
  //final List<DropdownMenuEntry> _remotes = [
  //  DropdownMenuEntry(value: 0, label: 'Hello'),
  //  DropdownMenuEntry(value: 1, label: 'dadas'),
  //];

  //int _selectedRemote = 0;

  void onTap(int key) {
    BleController().writeToDevice(device, data);
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
                    ElevatedButton(onPressed:() {}, child: Icon(Icons.power_settings_new)),
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
