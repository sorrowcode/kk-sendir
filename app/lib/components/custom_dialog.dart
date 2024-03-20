import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:Remote_Control/pages/home_page.dart';
import 'package:Remote_Control/components/device_item.dart';

class CustomDialog extends StatefulWidget {
  CustomDialog({
    super.key,
    required this.deviceItems,
    });

  List<DeviceItem> deviceItems;

  @override
  State<CustomDialog> createState() => _CustomDigalogState();
}

class _CustomDigalogState extends State<CustomDialog> {

  TextEditingController textController = TextEditingController();

  late String _deviceName;

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Align(
              alignment: Alignment.topRight,
              child: IconButton(
                icon: const Icon(Icons.close),
                onPressed: () {
                  setState(() {
                    Navigator.of(context).pop();
                  });
                },
              )
            ),
            TextField(
              controller: textController,
              maxLines: null,
              inputFormatters: [
                FilteringTextInputFormatter.deny(
                  RegExp(r'^\s')
                )
              ],
              decoration: InputDecoration(
                hintStyle: TextStyle(
                  color: Theme.of(context).colorScheme.primary,
                ),
                hintText: 'Enter a name for the device'
              ),
            ),
             const SizedBox(
              height: 10.0,
             ),
             ElevatedButton.icon(
              onPressed: () {
                setState(() {
                  _deviceName = textController.text;
                  if (_deviceName == "") {
                  }else {
                   widget.deviceItems.add(DeviceItem(
                    deviceName: _deviceName,
                   ));
                   Navigator.of(context).pop();
                   textController.clear();
                  }
                });
              },
              label: const Text('Add Device'),
              icon: const Icon(Icons.add),
             ),
          ],
        ),
      ),
    );
  }
}