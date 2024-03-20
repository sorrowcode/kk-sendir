import 'package:flutter/material.dart';

import 'custom_dialog.dart';
import 'package:Remote_Control/components/device_item.dart';

class CustomFAB extends StatefulWidget {
  CustomFAB({
    super.key,
    required this.deviceItems,
    });

  List<DeviceItem> deviceItems;

  @override
  State<CustomFAB> createState() => _CustomFABState();
}

class _CustomFABState extends State<CustomFAB> {
  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      onPressed: () {
        showDialog<String>(
          context: context,
          builder: (BuildContext context) => CustomDialog(deviceItems: widget.deviceItems,),
        );
      },
      shape: const CircleBorder(),
      elevation: 2,
      child: const Icon(Icons.add),
    );
  }
}