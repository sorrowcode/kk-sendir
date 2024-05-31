import '../components/key_item.dart';

class KeyList {
  static final List<KeyItem> keys = [
    KeyItem(
        protocol: 2,
        address: 0xEF00.toUnsigned(16),
        command: 0x3,
        flags: 2,
        key: 0),
    KeyItem(
        protocol: 2,
        address: 0xEF00.toUnsigned(16),
        command: 0x2,
        flags: 2,
        key: 1),
  ];
}
