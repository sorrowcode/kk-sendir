import 'package:app/components/device_item.dart';
import 'package:app/pages/settings.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class CustomDrawer extends StatefulWidget {
  CustomDrawer({super.key, required this.deviceItems});

  List<DeviceItem> deviceItems;
  //int selectedDevice = 0;

  @override
  State<CustomDrawer> createState() => _CustomDrawerState();
}

class _CustomDrawerState extends State<CustomDrawer> {

  List<Widget> _generateDeviceList() {
    List<Widget> devices = [];
    for(DeviceItem item in widget.deviceItems) {
      devices.add(Card(
        child: ListTile(
          title: Text(item.deviceName),
          trailing: Icon(Icons.more_vert),
        ),
      ),);
    }
    return devices;
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
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
    ));
  }
}

/*
class Device extends StatefulWidget {
  Device({
    super.key,
    required this.name,
    required this.listIndex,
    this.isSelected = false,
    this.online = false,
  });

  int listIndex;
  bool isSelected;
  final bool online;
  final String name;

  @override
  State<Device> createState() => _DeviceState();
}



Scaffold(
        appBar: PreferredSize(
          preferredSize: const Size.fromHeight(60),
          child: Container(
            margin: const EdgeInsets.only(top: 20),
            child: AppBar(
              leading: IconButton(
                onPressed: () {
                  setState(() {
                    widget.devices.add(Device(
                      name: 'Devicesadded',
                      isSelected: true,
                      listIndex: 0,
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
          child: ListView.builder(
            itemCount: widget.devices.length,
            itemBuilder: (context, index) {
              return widget.devices[index];
            },
          ),
        ),
      ),

class asdasd extends StatefulWidget {
  const asdasd({super.key});

  @override
  State<asdasd> createState() => _asdasdState();
}

class _asdasdState extends State<asdasd> {
  @override
  Widget build(BuildContext context) {
    
    return ListTile(
      onTap: () {
        setState(() {
          if (widget.isSelected) {
            widget.isSelected = false;
          }else {
            widget.isSelected = true;
          }
        });
      },
      title: Text(widget.name, style: const TextStyle(fontSize: 20,)),
      trailing: const Icon(Icons.more_vert),
    );
    
  }
}


class _DeviceState extends State<Device> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Container(
        height: 40,
        color: Colors.amber,
        child: Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            widget.isSelected
                ? Container(
                    width: 5,
                    height: 20,
                    color: Colors.green,
                  )
                : Container(),
            Text(widget.name,
                style: const TextStyle(
                  fontSize: 20,
                )),
            Visibility(
              visible: widget.isSelected,
              child: IconButton(
                iconSize: 30,
                onPressed: () {
                  setState(() {
                    CustomDrawer customDrawer = CustomDrawer();
                    customDrawer.devices.removeAt(widget.listIndex);
                    print(widget);
                  });
                },
                icon: const Icon(Icons.more_vert),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
*/
