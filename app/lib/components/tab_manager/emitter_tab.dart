// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';

import 'package:remote_control/pages/home_page.dart';


class EmitterTab extends StatefulWidget {
  const EmitterTab({super.key});

  @override
  State<EmitterTab> createState() => _EmitterTabState();
}

class _EmitterTabState extends State<EmitterTab> {
  
  final List<DropdownMenuEntry> _remotes = [
    DropdownMenuEntry(value: 0, label: 'Hello'),
    DropdownMenuEntry(value: 1, label: 'dadas'),
  ];

  int _selectedRemote = 0;


  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          Text(_selectedRemote.toString()),
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
              )
            ],
          ),
        ],
      ),
    );
  }
}
