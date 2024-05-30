import 'package:uuid/uuid.dart';
import 'package:flutter_blue_plus/flutter_blue_plus.dart';


class DeviceItem {
  late String deviceName;
  String uuid = const Uuid().v4();
  DeviceIdentifier remoteID;
  DeviceItem({
    required this.deviceName,
    required this.remoteID,
  });
}
