import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_blue_plus/flutter_blue_plus.dart';

import 'package:remote_control/components/device_item.dart';

class CustomDialog extends StatefulWidget {
  const CustomDialog({
    super.key,
    required this.deviceItems,
    required this.onTap,
    required this.selMode,
    required this.remoteID,
  });

  final List<DeviceItem> deviceItems;
  final void Function(String, DeviceIdentifier) onTap;
  final int selMode;
  final DeviceIdentifier remoteID;

  @override
  State<CustomDialog> createState() => _CustomDigalogState();
}

class _CustomDigalogState extends State<CustomDialog> {
  TextEditingController textController = TextEditingController();

  late String _deviceName;

  String buttonName() {
    if (widget.selMode == 0) {
      return "Add Device";
    } else {
      return "Edit Name";
    }
  }

  IconData buttonIcon() {
    if (widget.selMode == 0) {
      return Icons.add;
    } else {
      return Icons.edit;
    }
  }

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
                  color: Theme.of(context).colorScheme.onSurface,
                  icon: const Icon(Icons.close),
                  onPressed: () {
                    setState(() {
                      Navigator.of(context).pop();
                    });
                  },
                )),
            TextField(
              controller: textController,
              maxLength: 50,
              inputFormatters: [
                FilteringTextInputFormatter.deny(RegExp(r'^\s'))
              ],
              decoration: InputDecoration(
                  hintStyle: TextStyle(
                    color: Theme.of(context).colorScheme.primary,
                  ),
                  hintText: 'Enter a name for the device'),
              textAlign: TextAlign.center,
            ),
            const SizedBox(
              height: 10.0,
            ),
            ElevatedButton.icon(
              style: ButtonStyle(
                backgroundColor: MaterialStatePropertyAll(Theme.of(context).colorScheme.primary),
              ),
              onPressed: () {
                setState(() {
                  _deviceName = textController.text;
                  if (_deviceName == "") {
                  } else {
                    widget.onTap(_deviceName, widget.remoteID);
                    Navigator.of(context).pop();
                    textController.clear();
                  }
                });
              },
              label: Text(
                buttonName(),
                style: TextStyle(
                  color: Theme.of(context).colorScheme.onPrimary,
                ),
              ),
              icon: Icon(buttonIcon(),
                  color: Theme.of(context).colorScheme.onPrimary),
            ),
          ],
        ),
      ),
    );
  }
}
