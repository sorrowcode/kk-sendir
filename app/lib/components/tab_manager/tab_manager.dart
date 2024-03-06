import 'package:flutter/material.dart';
import 'package:app/components/custom_navigation_bar.dart';
import 'package:app/components/tab_manager/add_device_tab.dart';
import 'package:app/components/tab_manager/emitter_tab.dart';
import 'package:app/components/tab_manager/receiver_tab.dart';

class TabManager extends StatefulWidget {
  TabManager({super.key});
  int index = 0;

  @override
  State<TabManager> createState() => _TabManagerState();
}

class _TabManagerState extends State<TabManager> {
  final List<Widget> tabs = [
    AddDevicesTab(),
    EmitterTab(),
    ReceiverTab(),
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [tabs[TabManager().index]],
    );
  }
}
