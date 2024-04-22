import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:Remote_Control/components/device_item.dart';

class EditDeviceDialog extends StatefulWidget {
  const EditDeviceDialog({
    super.key,
    required this.deviceItems,
    });

  final List<DeviceItem> deviceItems;

  @override
  State<EditDeviceDialog> createState() => _CustomDigalogState();
}

class _CustomDigalogState extends State<EditDeviceDialog> {

  TextEditingController textController = TextEditingController();

  late String _deviceName;

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Theme.of(context).appBarTheme.backgroundColor,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Align(
              alignment: Alignment.topRight,
              child: IconButton(
                color: Theme.of(context).colorScheme.onBackground,
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
              textAlign: TextAlign.center,
            ),
             const SizedBox(
              height: 10.0,
             ),
             ElevatedButton.icon(
              style: ButtonStyle(
                backgroundColor: MaterialStatePropertyAll<Color>(Theme.of(context).colorScheme.primary),
              ),
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
              label: Text(
                'Add Device',
                style: TextStyle(
                  color: Theme.of(context).colorScheme.onPrimary,
                ),
                ),
              icon: const Icon(Icons.add),
             ),
          ],
        ),
      ),
    );
  }
}