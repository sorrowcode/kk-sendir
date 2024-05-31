import 'package:flutter_blue_plus/flutter_blue_plus.dart';
import 'package:remote_control/components/device_item.dart';
import 'package:remote_control/pages/home_page.dart';
import 'package:remote_control/pages/settings.dart';
import 'package:remote_control/components/custom_dialog.dart';

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
  void _removeAll() {
    setState(() {
      widget.deviceItems.clear();
      selectedDevice = '0';
    });
  }

  void _removeDevice(int index, String selUuid) {
    late int deviceIndex;
    for (DeviceItem item in widget.deviceItems) {
      if (item.uuid == selectedDevice) {
        deviceIndex = widget.deviceItems.indexOf(item);
        if (index == deviceIndex) {
          selectedDevice = '0';
        }
      }
    }
    setState(() {
      widget.deviceItems.removeAt(index);
    });
  }

  void _onTap(String name, String uuid) {
    setState(() {
      selectedDevice = uuid;
    });
  }

  void _onRename(String newName, String selUuid) {
    setState(() {
      for (DeviceItem items in widget.deviceItems) {
        if (selUuid == items.uuid) {
          items.deviceName = newName;
        }
      }
    });
  }

  List<Widget> _generateDeviceList() {
    List<Widget> devices = [];
    for (DeviceItem item in widget.deviceItems) {
      int index = widget.deviceItems.indexOf(item);
      devices.add(Device(
        name: item.deviceName,
        listIndex: index,
        removeEntry: _removeDevice,
        removeAll: _removeAll,
        key: ValueKey(item.uuid),
        uuid: item.uuid,
        remoteID: item.remoteID,
        selectedDevice: selectedDevice,
        deviceItems: widget.deviceItems,
        online: false,
        onRename: (deviceName, remoteID) {
          _onRename(deviceName, item.uuid);
        },
        onTap: () {
          _onTap(item.deviceName, item.uuid);
        },
      ));
    }
    return devices;
  }

  void _updateDeviceList(int oldIndex, int newIndex) {
    setState(() {
      if (oldIndex < newIndex) {
        newIndex--;
      }
      final device = widget.deviceItems.removeAt(oldIndex);
      widget.deviceItems.insert(newIndex, device);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
        width: MediaQuery.of(context).size.width * 0.85,
        child: Scaffold(
            appBar: PreferredSize(
              preferredSize: Size(MediaQuery.of(context).size.width,
                  MediaQuery.of(context).size.height / 6),
              child: Container(
                color: Theme.of(context).appBarTheme.backgroundColor,
                child: Padding(
                  padding: const EdgeInsets.only(top: 20),
                  child: AppBar(
                    title: const Text(
                      'Devices',
                      style: TextStyle(fontSize: 40.0),
                    ),
                    actions: [
                      IconButton(
                        color: Theme.of(context).colorScheme.onSurface,
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
                              onPressed: () => _removeAll(),
                              child: Text(
                                'Remove All',
                                style: TextStyle(
                                  color:
                                      Theme.of(context).colorScheme.onPrimary,
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
                onReorder: _updateDeviceList,
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
    required this.onRename,
    required this.uuid,
    required this.remoteID,
    required this.selectedDevice,
    required this.deviceItems,
    required this.online,
  });
  final void Function() removeAll;
  final void Function(int, String) removeEntry;
  final void Function() onTap;
  final void Function(String, DeviceIdentifier) onRename;
  final int listIndex;
  final String selectedDevice;
  final bool online;
  final String name;
  final String uuid;
  final DeviceIdentifier remoteID;
  final List<DeviceItem> deviceItems;

  @override
  State<Device> createState() => _DeviceState();
}

class _DeviceState extends State<Device> {
  bool _isSelected() {
    if (widget.selectedDevice == widget.uuid) {
      return true;
    } else {
      return false;
    }
  }

  void _changeName() {
    showDialog<String>(
      context: context,
      builder: (BuildContext context) => CustomDialog(
        deviceItems: widget.deviceItems,
        onTap: widget.onRename,
        selMode: 1,
        remoteID: widget.remoteID,
      ),
    );
  }

  Color _customColor() {
    if (widget.online == true) {
      return Theme.of(context).colorScheme.onPrimary;
    } else {
      return Theme.of(context).colorScheme.primary;
    }
  }

  ShapeBorder _border() {
    if (widget.online == true) {
      return StadiumBorder(
          side: BorderSide(
        width: 2,
        color: Theme.of(context).colorScheme.outline,
      ));
    } else {
      return const StadiumBorder(
          side: BorderSide(
        width: 0,
        color: Colors.transparent,
      ));
    }
  }

  Widget _activeDevice() {
    if (_isSelected() == true) {
      return const SizedBox(
        height: 70,
        width: 10,
        child: VerticalDivider(
          width: 6,
          thickness: 2,
          indent: 20,
          endIndent: 20,
          color: Colors.white,
        ),
      );
    } else {
      return const Placeholder(
        fallbackWidth: 0,
        fallbackHeight: 0,
      );
    }
  }

  /*
  final _cardWidgetKey = GlobalKey();
  double? _cardWidgetHeight;

  void _getSize() {
    setState(() {
      _cardWidgetHeight = _cardWidgetKey.currentContext!.size!.height;
    });
  }
  */

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        _activeDevice(),
        Expanded(
          child: Card(
            color: widget.online
                ? Theme.of(context).colorScheme.surfaceVariant
                : Theme.of(context).colorScheme.onSurfaceVariant,
            shape: _border(),
            child: ListTile(
              splashColor: Colors.transparent,
              onTap: () {
                setState(() {
                  widget.onTap();
                });
              },
              title: Text(
                widget.name,
              ),
              trailing: MenuAnchor(
                builder: (BuildContext context, MenuController controller,
                    Widget? child) {
                  return IconButton(
                    color: _customColor(),
                    onPressed: () {
                      if (controller.isOpen) {
                        controller.close();
                      } else {
                        controller.open();
                      }
                    },
                    icon: const Icon(Icons.more_vert),
                  );
                },
                menuChildren: [
                  MenuItemButton(
                    onPressed: () {
                      setState(() {
                        _changeName();
                      });
                    },
                    child: const Text('Edit'),
                  ),
                  MenuItemButton(
                    onPressed: () {
                      setState(() {
                        widget.removeEntry(widget.listIndex, widget.uuid);
                      });
                    },
                    child: const Text('Delete'),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
