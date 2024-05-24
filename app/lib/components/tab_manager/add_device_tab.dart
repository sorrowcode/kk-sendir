import 'dart:async';
import 'package:flutter/material.dart';

import 'package:flutter_blue_plus/flutter_blue_plus.dart';

import '../device_item.dart';
import 'bluetooth_off_screen.dart';
import 'scan_screen.dart';


class AddDevicesTab extends StatefulWidget {
  const AddDevicesTab({
    super.key,
    required this.deviceItems,
    required this.onTap,
    });

  final List<DeviceItem> deviceItems;
  final void Function(String) onTap;

  @override
  State<AddDevicesTab> createState() => _AddDevicesTabState();
}

class _AddDevicesTabState extends State<AddDevicesTab> {
  BluetoothAdapterState _adapterState = BluetoothAdapterState.unknown;

  late StreamSubscription<BluetoothAdapterState> _adapterStateStateSubscription;

  @override
  void initState() {
    super.initState();
    _adapterStateStateSubscription = FlutterBluePlus.adapterState.listen((state) {
      _adapterState = state;
      if (mounted) {
        setState(() {});
      }
    });
  }

  @override
  void dispose() {
    _adapterStateStateSubscription.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return _adapterState == BluetoothAdapterState.on
        ? ScanScreen(deviceItems: widget.deviceItems, onTap: widget.onTap, selMode: 0,)
        : BluetoothOffScreen(adapterState: _adapterState);
  }
}