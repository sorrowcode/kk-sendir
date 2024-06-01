import '../components/items/key_item.dart';

// import 'package:flutter/material.dart';

// import 'package:flutter_draggable_gridview/flutter_draggable_gridview.dart';

class CustomRemote {
  static final List<KeyItem> ledStripe = [
    KeyItem(
      protocol: 1,
      address: 1.toUnsigned(16),
      command: 3,
      flags: 0,
      key: 0,
    ),
    KeyItem(
      protocol: 1,
      address: 1.toUnsigned(16),
      command: 2,
      flags: 0,
      key: 1,
    ),
    KeyItem(
      protocol: 1,
      address: 1.toUnsigned(16),
      command: 0,
      flags: 0,
      key: 12,
    ),
    KeyItem(
      protocol: 1,
      address: 1.toUnsigned(16),
      command: 1,
      flags: 0,
      key: 14,
    ),
    KeyItem(
      protocol: 1,
      address: 1.toUnsigned(16),
      command: 4,
      flags: 0,
      key: 3,
    ),
    KeyItem(
      protocol: 1,
      address: 1.toUnsigned(16),
      command: 5,
      flags: 0,
      key: 4,
    ),
    KeyItem(
      protocol: 1,
      address: 1.toUnsigned(16),
      command: 6,
      flags: 0,
      key: 5,
    ),
    KeyItem(
      protocol: 1,
      address: 1.toUnsigned(16),
      command: 7,
      flags: 0,
      key: 6,
    ),
    KeyItem(
      protocol: 1,
      address: 1.toUnsigned(16),
      command: 11,
      flags: 0,
      key: 7,
    ),
    KeyItem(
      protocol: 1,
      address: 1.toUnsigned(16),
      command: 15,
      flags: 0,
      key: 8,
    ),
    KeyItem(
      protocol: 1,
      address: 1.toUnsigned(16),
      command: 19,
      flags: 0,
      key: 9,
    ),
    KeyItem(
      protocol: 1,
      address: 1.toUnsigned(16),
      command: 23,
      flags: 0,
      key: 10,
    ),
  ];

  static final List<KeyItem> defaultList = [
    KeyItem(
        protocol: 1, address: 1.toUnsigned(16), command: 3, flags: 0, key: 0),
    KeyItem(
        protocol: 1, address: 1.toUnsigned(16), command: 2, flags: 0, key: 15),
    KeyItem(
        protocol: 1, address: 1.toUnsigned(16), command: 13, flags: 0, key: 19),
    KeyItem(
      protocol: 1,
      address: 1.toUnsigned(16),
      command: 0,
      flags: 0,
      key: 1,
    ),
    KeyItem(
      protocol: 1,
      address: 1.toUnsigned(16),
      command: 1,
      flags: 0,
      key: 2,
    )
  ];

  /*
  static final Widget draggableRemoteLayout = DraggableGridViewBuilder(
    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
      crossAxisCount: 4,
      childAspectRatio: 1,
    ),
    dragCompletion: (List<DraggableGridItem> list, int beforeIndex, int afterIndex) {
      print( 'onDragAccept: $beforeIndex -> $afterIndex');
    },
    children: List.generate(, (index) => null),
  );
  */
}
