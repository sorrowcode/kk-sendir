// ignore_for_file: must_be_immutable

import 'package:Remote_Control/components/device_item.dart';
import 'package:Remote_Control/pages/home_page.dart';
//import 'package:Remote_Control/pages/home_page.dart';
import 'package:Remote_Control/pages/settings.dart';
//import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
//import 'package:flutter/widgets.dart';
import 'package:uuid/uuid.dart';

var uuidCreator = Uuid();

class CustomDrawer extends StatefulWidget {
  CustomDrawer({
    super.key,
    required this.deviceItems,
  });

  List<DeviceItem> deviceItems;

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
        onTap: () {
          setState(() {
            selectedDevice = item.uuid;
          });
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
      final Device = widget.deviceItems.removeAt(oldIndex);
      widget.deviceItems.insert(newIndex, Device);
    });
  }

  int lenghtOfList() {
    int length = 0;
    for (DeviceItem items in widget.deviceItems) {
      length++;
    }
    return length;
  }

  late var CustomUUID;

  bool Editable = false;

  @override
  Widget build(BuildContext context) {
    return Drawer(
        width: MediaQuery.of(context).size.width * 0.7,
        child: Scaffold(
            appBar: PreferredSize(
              preferredSize: Size(MediaQuery.of(context).size.width,
                  MediaQuery.of(context).size.height / 6),
              child: Container(
                margin: const EdgeInsets.only(top: 20),
                child: AppBar(
                  leading: Row(
                    children: [
                      IconButton(
                        onPressed: () {
                          setState(() {
                            widget.deviceItems.add(DeviceItem(
                              uuid: CustomUUID = uuidCreator.v4(),
                              deviceName: CustomUUID,
                            ));
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
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          ElevatedButton(
                            onPressed: () {
                              setState(() {
                                Editable ? Editable = false : Editable = true;
                              });
                            },
                            child: const Text("Edit"),
                          ),
                          ElevatedButton(
                            onPressed: () => removeAll(),
                            child: const Text("Remove All"),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
            body: Container(
              margin: const EdgeInsets.fromLTRB(20, 50, 10, 0),
              child: ReorderableListView(
                buildDefaultDragHandles: Editable,
                onReorder: updateDeviceList,
                children: _generateDeviceList(),
              ),
              /*
          child: ListView(
                children: _generateDeviceList()
                ),
                */
            )));
  }
}

class Device extends StatefulWidget {
  Device({
    super.key,
    required this.name,
    required this.listIndex,
    required this.removeEntry,
    required this.removeAll,
    required this.onTap,
    required this.uuid,
    this.selectedDevice,
    this.online = false,
  });
  void Function() removeAll;
  void Function(int) removeEntry;
  void Function() onTap;
  int listIndex;
  var selectedDevice;
  final bool online;
  final String name;
  var uuid;

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

  @override
  Widget build(BuildContext context) {
    return Card(
      color: isSelected() ? Colors.green : Colors.red,
      child: ListTile(
        splashColor: Colors.transparent,
        onTap: () {
          setState(() {
            widget.onTap();
          });
        },
        title: Text(widget.name),
        trailing: PopupMenuButton(
          onSelected: (item) {
            setState(() {
              if (item == 0 || item == null) {
                widget.removeEntry(widget.listIndex);
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

/*
child: ListView(
          children: [
            SizedBox(
              height: MediaQuery.of(context).size.height / 8,
              child: const DrawerHeader(
                child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Devices',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 30.0,
                    ),
                  ),
                  IconButton(
                    onPressed: null,
                    icon: Icon(Icons.settings),
                    padding: EdgeInsets.only(right: 15.0),
                  ),
                ],
              )),
            ),
            Column(
              children: _generateDeviceList(),
            ),
          ],
    )

Scaffold(
        appBar: PreferredSize(
          preferredSize: const Size.fromHeight(60),
          child: Container(
            margin: const EdgeInsets.only(top: 20),
            child: AppBar(
              leading: IconButton(
                onPressed: () {
                  setState(() {
                    widget.deviceItems.add(DeviceItem(
                      deviceName: 'Devicesadded',
                    ));
                  });
                },
                icon: const Icon(Icons.add),
              ),
              title: const Text(
                'Devices',
                style: TextStyle(fontSize: 40.0),
              ),
              actions: [
                IconButton(
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
            ),
          ),
        ),
        body: Container(
          color: Colors.yellow,
          margin: const EdgeInsets.fromLTRB(50, 50, 10, 0),
          child: ListView(
            children: [
              _generateDeviceList();
            ],
        ),
      )
        )
*/
