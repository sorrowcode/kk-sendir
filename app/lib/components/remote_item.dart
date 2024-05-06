import 'package:uuid/uuid.dart';

class RemoteControl {
  late String remoteName;
  String uuid = const Uuid().v4();
  var buttons = [];
  RemoteControl({
    required this.remoteName,
  });
}