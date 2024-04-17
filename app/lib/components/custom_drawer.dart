
import 'package:Remote_Control/components/device_item.dart';
import 'package:Remote_Control/pages/home_page.dart';
import 'package:Remote_Control/pages/settings.dart';
import 'package:Remote_Control/components/edit_device_dialog.dart';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/material.dart';

class CustomDrawer extends StatefulWidget {
  const CustomDrawer({
    super.key,
    required this.deviceItems,
  });

  final List<DeviceItem> deviceItems;

  @override
  State<CustomDrawer> createState() => _CustomDrawerState();
}

class _CustomDrawerState extends State<CustomDrawer> {
  void removeAll() {
    setState(() {
      widget.deviceItems.clear();
    });
  }

  void removeEntry(index) {
    setState(() {
      widget.deviceItems.removeAt(index);
      selectedDevice = '0';
    });
  }
  void onTap(String name, String uuid) {
    setState(() {
      selectedDevice = uuid;
    });
  }
  List<Widget> _generateDeviceList() {
    List<Widget> devices = [];
    for (DeviceItem item in widget.deviceItems) {
      int index = widget.deviceItems.indexOf(item);
      devices.add(Device(
        name: item.deviceName,
        listIndex: index,
        removeEntry: removeEntry,
        removeAll: removeAll,
        key: ValueKey(item.uuid),
        uuid: item.uuid,
        selectedDevice: selectedDevice,
        deviceItems: widget.deviceItems,
        onTap: () {
          onTap(item.deviceName, item.uuid);
        },
      ));
    }
    return devices;
  }

  void updateDeviceList(int oldIndex, int newIndex) {
    setState(() {
      if (oldIndex < newIndex) {
        newIndex--;
      }
      final device = widget.deviceItems.removeAt(oldIndex);
      widget.deviceItems.insert(newIndex, device);
    });
  }

  int lenghtOfList() {
    return widget.deviceItems.length;
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
        width: MediaQuery.of(context).size.width * 0.85,
        child: Scaffold(
            appBar: PreferredSize(
              preferredSize: Size(
                MediaQuery.of(context).size.width,
                MediaQuery.of(context).size.height / 6
                ),
              child: Container(
                color: Theme.of(context).appBarTheme.backgroundColor,
                child: Padding(
                  padding: const EdgeInsets.only(top: 20),
                  child: AppBar(
                      leading: Row(
                        children: [
                          IconButton(
                            onPressed: () {
                              setState(() {
                                widget.deviceItems.add(DeviceItem.debug());
                              });
                            },
                            icon: const Icon(Icons.add),
                          ),
                        ],
                      ),
                      title: const Text(
                        'Devices',
                        style: TextStyle(fontSize: 40.0),
                      ),
                      actions: [
                        IconButton(
                          color: Theme.of(context).colorScheme.onBackground,
                          iconSize: 30,
                          onPressed: () {
                            setState(() {
                              Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) => const Settings(),
                              ));
                            });
                          },
                          icon: const Icon(Icons.settings),
                        ),
                      ],
                      bottom: PreferredSize(
                        preferredSize: const Size.fromHeight(1),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            mainAxisSize: MainAxisSize.max,
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              ElevatedButton(
                                style: ButtonStyle(
                                  backgroundColor: MaterialStatePropertyAll(Theme.of(context).colorScheme.primary),
                                ),
                                onPressed: () => removeAll(),
                                child: Text(
                                  'Remove All',
                                  style: TextStyle(
                                    color: Theme.of(context).colorScheme.onPrimary,
                                  ),
                                  ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                ),
              ),
            ),
            body: Container(
              margin: const EdgeInsets.fromLTRB(10, 50, 10, 0),
              child: ReorderableListView(
                buildDefaultDragHandles: true,
                onReorder: updateDeviceList,
                children: _generateDeviceList(),
              ),
            )));
  }
}

class Device extends StatefulWidget {
  const Device({
    super.key,
    required this.name,
    required this.listIndex,
    required this.removeEntry,
    required this.removeAll,
    required this.onTap,
    required this.uuid,
    required this.selectedDevice,
    required this.deviceItems,
    this.online = false,
  });
  final void Function() removeAll;
  final void Function(int) removeEntry;
  final void Function() onTap;
  final int listIndex;
  final String selectedDevice;
  final bool online;
  final String name;
  final String uuid;
  final List<DeviceItem> deviceItems;

  @override
  State<Device> createState() => _DeviceState();
}

class _DeviceState extends State<Device> {
  bool isSelected() {
    if (widget.selectedDevice == widget.uuid) {
      return true;
    } else {
      return false;
    }
  }

  ShapeBorder border() {
    if (isSelected() == true) {
      return StadiumBorder(
        side: BorderSide(
          width: 2,
          color: Theme.of(context).colorScheme.outline,
        )
      );
    } else {
      return const StadiumBorder(
        side: BorderSide(
          width: 0,
          color: Colors.transparent,
        )
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      color: isSelected() ? Theme.of(context).colorScheme.surfaceVariant : Theme.of(context).colorScheme.onSurfaceVariant,
      shape: border(),
      child: ListTile(
        splashColor: Colors.transparent,
        onTap: () {
          setState(() {
            widget.onTap();
          });
        },
        title: Text(widget.name),
        trailing: PopupMenuButton(
          iconColor: Theme.of(context).colorScheme.onBackground,
          onSelected: (item) {
            setState(() {
              if (item == 0 || item == null) {
                widget.removeEntry(widget.listIndex);
              } else if (item == 1) {
                EditDeviceDialog(deviceItems: widget.deviceItems);
              }
            });
          },
          itemBuilder: (BuildContext context) => <PopupMenuEntry>[
            const PopupMenuItem(
              value: 1,
              child: Text('Edit'),
            ),
            const PopupMenuItem(
              value: 0,
              child: Text('Delete'),
            ),
          ],
        ),
      ),
    );
  }
}
