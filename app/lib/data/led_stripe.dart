import '../components/items/key_item.dart';
// import '../components/tab_manager/emitter_tab.dart';

// import 'package:flutter/material.dart';

// import 'package:flutter_draggable_gridview/flutter_draggable_gridview.dart';

class LedStripe {
  static final List<KeyItem> keyList = [
    KeyItem(
      protocol: 1,
      address: 1.toUnsigned(16),
      command: 0,
      flags: 0,
      key: 0,
    ),
    KeyItem(
      protocol: 1,
      address: 1.toUnsigned(16),
      command: 1,
      flags: 0,
      key: 1,
    ),
    KeyItem(
      protocol: 1,
      address: 1.toUnsigned(16),
      command: 2,
      flags: 0,
      key: 2,
    ),
    KeyItem(
      protocol: 1,
      address: 1.toUnsigned(16),
      command: 3,
      flags: 0,
      key: 3,
    ),
    KeyItem(
      protocol: 1,
      address: 1.toUnsigned(16),
      command: 4,
      flags: 0,
      key: 4,
    ),
    KeyItem(
      protocol: 1,
      address: 1.toUnsigned(16),
      command: 5,
      flags: 0,
      key: 5,
    ),
    KeyItem(
      protocol: 1,
      address: 1.toUnsigned(16),
      command: 6,
      flags: 0,
      key: 6,
    ),
    KeyItem(
      protocol: 1,
      address: 1.toUnsigned(16),
      command: 7,
      flags: 0,
      key: 7,
    ),
    KeyItem(
      protocol: 1,
      address: 1.toUnsigned(16),
      command: 8,
      flags: 0,
      key: 8,
    ),
    KeyItem(
      protocol: 1,
      address: 1.toUnsigned(16),
      command: 9,
      flags: 0,
      key: 9,
    ),
    KeyItem(
      protocol: 1,
      address: 1.toUnsigned(16),
      command: 10,
      flags: 0,
      key: 10,
    ),
    KeyItem(
      protocol: 1,
      address: 1.toUnsigned(16),
      command: 11,
      flags: 0,
      key: 11,
    ),
    KeyItem(
      protocol: 1,
      address: 1.toUnsigned(16),
      command: 12,
      flags: 0,
      key: 12,
    ),
    KeyItem(
      protocol: 1,
      address: 1.toUnsigned(16),
      command: 13,
      flags: 0,
      key: 13,
    ),
    KeyItem(
      protocol: 1,
      address: 1.toUnsigned(16),
      command: 14,
      flags: 0,
      key: 14,
    ),
    KeyItem(
      protocol: 1,
      address: 1.toUnsigned(16),
      command: 23, //Inverted because remote is wrong configured
      flags: 0,
      key: 15,
    ),
    KeyItem(
      protocol: 1,
      address: 1.toUnsigned(16),
      command: 16,
      flags: 0,
      key: 16,
    ),
    KeyItem(
      protocol: 1,
      address: 1.toUnsigned(16),
      command: 17,
      flags: 0,
      key: 17,
    ),
    KeyItem(
      protocol: 1,
      address: 1.toUnsigned(16),
      command: 18,
      flags: 0,
      key: 18,
    ),
    KeyItem(
      protocol: 1,
      address: 1.toUnsigned(16),
      command: 19,
      flags: 0,
      key: 19,
    ),
    KeyItem(
      protocol: 1,
      address: 1.toUnsigned(16),
      command: 20,
      flags: 0,
      key: 20,
    ),
    KeyItem(
      protocol: 1,
      address: 1.toUnsigned(16),
      command: 21,
      flags: 0,
      key: 21,
    ),
    KeyItem(
      protocol: 1,
      address: 1.toUnsigned(16),
      command: 22,
      flags: 0,
      key: 22,
    ),
    KeyItem(
      protocol: 1,
      address: 1.toUnsigned(16),
      command: 15, //Inverted because remote is wrong configured
      flags: 0,
      key: 23,
    ),
  ];

  /*
  static final Widget draggableRemoteLayout = DraggableGridViewBuilder(
    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
      crossAxisCount: 4,
      childAspectRatio: 1,
    ),
    dragCompletion: (List<DraggableGridItem> list, int beforeIndex, int afterIndex) {},
    children: [

    ],
  );
  
  static final List<Widget> buttonList  = [
    ElevatedButton(onPressed: () {}, child: const Icon(Icons.add))
  ];
  */
}
