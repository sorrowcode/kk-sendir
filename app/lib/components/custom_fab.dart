import 'package:flutter/material.dart';
import 'package:flutter_blue_plus/flutter_blue_plus.dart';
import 'package:remote_control/components/tab_manager/add_device_tab.dart';

import 'package:remote_control/components/device_item.dart';

class CustomFAB extends StatefulWidget {
  const CustomFAB({
    super.key,
    required this.deviceItems,
    required this.onTap,
    required this.selMode,
  });

  final List<DeviceItem> deviceItems;
  final void Function(String, DeviceIdentifier) onTap;
  final int selMode;

  @override
  State<CustomFAB> createState() => _CustomFABState();
}

class _CustomFABState extends State<CustomFAB> {
  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      onPressed: () {
        showModalBottomSheet(
          context: context,
          constraints: BoxConstraints(
            minWidth: MediaQuery.of(context).size.width,
          ),
          builder: (context) => SizedBox(
            height: MediaQuery.of(context).size.height / 5,
            child: Padding(
              padding: const EdgeInsets.only(top: 30),
              child: Column(
                children: [
                  TextButton(
                    onPressed: () {
                      setState(() {
                        
                        Navigator.of(context).pop();
                        Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => AddDevicesTab(deviceItems: widget.deviceItems, onTap: widget.onTap,),
                            ));
                        /*
                        showDialog<String>(
                            context: context,
                            builder: (BuildContext context) => CustomDialog(
                                deviceItems: widget.deviceItems,
                                onTap: widget.onTap,
                                selMode: widget.selMode
                                )
                        );
                        */
                      });

                    },
                    child: const Text('Add Device'),
                  ),
                  const TextButton(
                    onPressed: null,
                    child: Text('Add Remote'),
                  )
                ],
              ),
            ),
          ),
        );
        /*
        showDialog<String>(
          context: context,
          builder: (BuildContext context) => CustomDialog(deviceItems: widget.deviceItems, onTap: widget.onTap, selMode: widget.selMode,),
        );
        */
      },
      shape: const CircleBorder(),
      elevation: 2,
      child: const Icon(Icons.add),
    );
  }
}
