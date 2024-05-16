import 'package:uuid/uuid.dart';

class DeviceItem {
  late String deviceName;
  String uuid = const Uuid().v4();
  DeviceItem({
    required this.deviceName,
  });
  DeviceItem.debug() {
    deviceName = uuid;
  }
}
