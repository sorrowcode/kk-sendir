import 'package:flutter/material.dart';

class CustomNavigationBar extends StatelessWidget {
  final int selectedIndex;
  final void Function(int) onItemTapped;
  const CustomNavigationBar(
      {super.key, required this.selectedIndex, required this.onItemTapped});

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      type: BottomNavigationBarType.fixed,
      backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      items: [
        const BottomNavigationBarItem(
          icon: Icon(Icons.settings_remote_outlined),
          activeIcon: Icon(Icons.settings_remote),
          label: "Emitter",
        ),
        BottomNavigationBarItem(
          icon: Transform.scale(
            scaleY: -1,
            child: const Icon(
              Icons.signal_wifi_0_bar,
            ),
          ),
          label: "Receiver",
          activeIcon: Transform.scale(
            scaleY: -1,
            child: const Icon(
              Icons.signal_wifi_4_bar,
            ),
          ),
        )
      ],
      currentIndex: selectedIndex,
      onTap: onItemTapped,
    );
  }
}
