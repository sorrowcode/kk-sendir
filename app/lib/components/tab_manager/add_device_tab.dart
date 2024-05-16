import 'package:flutter/material.dart';

import 'package:remote_control/components/device_item.dart';
import 'package:remote_control/pages/home_page.dart';
import 'package:remote_control/components/ble_controller.dart';

import 'package:flutter_blue/flutter_blue.dart';
import 'package:get/get.dart';

class AddDevicesTab extends StatefulWidget {
  const AddDevicesTab({
    super.key,
    required this.deviceItems,
    });

  final List<DeviceItem> deviceItems;

  @override
  State<AddDevicesTab> createState() => _AddDevicesTabState();
}

class _AddDevicesTabState extends State<AddDevicesTab> {



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).appBarTheme.backgroundColor,
        leading: IconButton(
          onPressed: () {
            Navigator.of(context).pop(MaterialPageRoute(
              builder: (context) => const MyHomePage(),
            ));
          },
          icon: const Icon(Icons.arrow_back),
        ),
        title: const Text('Add Device'),
        centerTitle: true,
      ),
      body: Padding(
        padding: EdgeInsets.all(8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          mainAxisSize: MainAxisSize.max,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Text('Searching for devices...'),

            GetBuilder<BleController>(
          init: BleController(),
          builder: (BleController controller)
          {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  StreamBuilder<List<ScanResult>>(
                      stream: controller.scanResults,
                      builder: (context, snapshot) {
                        if (snapshot.hasData) {
                          return Expanded(
                            child: ListView.builder(
                                shrinkWrap: true,
                                itemCount: snapshot.data!.length,
                                itemBuilder: (context, index) {
                                  final data = snapshot.data![index];
                                  return Card(
                                    elevation: 2,
                                    child: ListTile(
                                      title: Text(data.device.name),
                                      subtitle: Text(data.device.id.id),
                                      trailing: Text(data.rssi.toString()),
                                      onTap: ()=> controller.connectToDevice(data.device),
                                    ),
                                  );
                                }),
                          );
                        }else{
                          return const Center(child: Text("No Device Found"),);
                        }
                      }),
                  const SizedBox(height: 10,),
                  ElevatedButton(onPressed: ()  async {
                    controller.scanDevices();
                    // await controller.disconnectDevice();
                  }, child: const Text("SCAN")),
                ],
              ),
            );
          },
        )
            /*
            ListView.builder(
              itemBuilder: (context, index) {
                if (widget.deviceItems.length == 0) {
                  
                }
                late String itemUuid;
                late String deviceName;
                for (DeviceItem item in widget.deviceItems) {
                  int itemIndex = widget.deviceItems.indexOf(item);
                  if (itemIndex == index) {
                    itemUuid = item.uuid;
                    deviceName = item.deviceName;
                  }
                }
                return Card(
                  key: ValueKey(widget.deviceItems[index]),
                );
              },
            ),
            */
          ],
        ),
      ),
    );
  }
}
