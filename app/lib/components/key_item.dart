class KeyItem {
  const KeyItem({
    required this.protocol,
    required this.address,
    required this.command,
    required this.flags,
    required this.key,
  });
  final int protocol;
  final int address;
  final int command;
  final int flags;
  final int key;
}
