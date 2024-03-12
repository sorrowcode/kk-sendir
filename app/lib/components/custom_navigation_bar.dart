import 'package:app/components/tab_manager/add_device_tab.dart';
import 'package:app/components/tab_manager/emitter_tab.dart';
import 'package:app/components/tab_manager/receiver_tab.dart';
import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';

class CustomNavigationBar extends StatefulWidget {
  CustomNavigationBar({super.key});

  final List<Widget> tabs = <Widget>[
    const AddDevicesTab(),
    const EmitterTab(),
    const ReceiverTab(),
  ];
  @override
  State<CustomNavigationBar> createState() => _CustomNavigationBarState();
}

class _CustomNavigationBarState extends State<CustomNavigationBar> {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Theme.of(context).colorScheme.inversePrimary,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 20),
        child: GNav(
          selectedIndex: 0,
          onTabChange: (selectedIndex) {
            return;
          },
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          backgroundColor: Theme.of(context).colorScheme.inversePrimary,
          tabBackgroundColor:
              Theme.of(context).colorScheme.primary.withOpacity(0.5),
          tabBorderRadius: 100,
          tabActiveBorder: Border.all(
              color: Theme.of(context).colorScheme.primary, width: 1),
          padding: const EdgeInsets.all(16),
          curve: Curves.easeInCirc,
          haptic: true,
          gap: 8,
          tabs: const [
            GButton(
              icon: Icons.settings_remote,
              text: 'Emitter',
            ),
            GButton(
              icon: Icons.settings_remote_outlined,
              text: 'Receiver',
            ),
          ],
        ),
      ),
    );

/*
    return BottomAppBar(
      color: Theme.of(context).colorScheme.inversePrimary,
      shape: const CircularNotchedRectangle(),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        mainAxisSize: MainAxisSize.max,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          IconButton(
            onPressed: () {
              setState(() {
                TabManager();
              });
            },
            icon: const Icon(Icons.settings_remote),
          ),
          SizedBox(
            width: MediaQuery.of(context).size.width / 10,
          ),
          IconButton(
            onPressed: () {
              setState(() {
                
              });
            },
            icon: const Icon(Icons.settings_remote_outlined),
          ),
        ],
      ),
    );
    */
  }
}
