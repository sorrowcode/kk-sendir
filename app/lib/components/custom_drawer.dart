// ignore_for_file: must_be_immutable

import 'package:Remote_Control/components/device_item.dart';
import 'package:Remote_Control/pages/home_page.dart';
//import 'package:Remote_Control/pages/home_page.dart';
import 'package:Remote_Control/pages/settings.dart';
//import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
//import 'package:flutter/widgets.dart';

class CustomDrawer extends StatefulWidget {
  CustomDrawer({super.key, required this.deviceItems, required this.selectedDevice,});


  List<DeviceItem> deviceItems;
  int selectedDevice;
  
  @override
  State<CustomDrawer> createState() => _CustomDrawerState();
}

class _CustomDrawerState extends State<CustomDrawer> {

  void removeEntry(index) {
    MyHomePage().selectedDevice = index ;
    setState(() {
      widget.deviceItems.removeAt(index);
    });
  }

  List<Widget> _generateDeviceList() {

    List<Widget> devices = [];
    for (DeviceItem item in widget.deviceItems) {
      int index = widget.deviceItems.indexOf(item);
      devices.add(

        Device(
          name: item.deviceName, 
          listIndex: index,
          removeEntry: removeEntry,
          selectedDevice: widget.selectedDevice,
          onTap: () {
            
            setState(() {
              widget.selectedDevice = index;
            });
          },
          )
      );
    }

    return devices;
  }

  


  @override
  Widget build(BuildContext context) {
    return Drawer(
        child: Scaffold(
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
          margin: const EdgeInsets.fromLTRB(20, 50, 10, 0),
          child: ListView(
            children: _generateDeviceList()
            ),
      )
        )
      );
  }
}

class Device extends StatefulWidget {
  Device({
    super.key,
    required this.name,
    required this.listIndex,
    required this.removeEntry,
    required this.onTap,
    this.selectedDevice = -1,
    this.online = false,
  });
  void Function(int) removeEntry;
  void Function() onTap;
  int listIndex;
  int selectedDevice;
  final bool online;
  final String name;

  @override
  State<Device> createState() => _DeviceState();
}





class _DeviceState extends State<Device> {

  bool isSelected() {
    if (widget.selectedDevice == widget.listIndex) {
      return true;
    }else {
      return false;
    }
  } 

  @override
  Widget build(BuildContext context) {
    return Card(
      color: isSelected()? Colors.green: Colors.red,
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
                if (item == 0) {
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
