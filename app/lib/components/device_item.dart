import 'package:uuid/uuid.dart';

class DeviceItem {
  String deviceName;
  String uuid = const Uuid().v4();
  DeviceItem({
    required this.deviceName,
  });
}
