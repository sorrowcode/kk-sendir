import 'package:flutter/material.dart';

class CustomBottomNavigationBar extends StatelessWidget {
  int selectedIndex;
  void Function(int) onItemTapped;
  CustomBottomNavigationBar(
      {super.key, required this.selectedIndex, required this.onItemTapped});

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      items: const [
        BottomNavigationBarItem(
            icon: Icon(Icons.settings_remote), label: "Emitter"),
        BottomNavigationBarItem(
            icon: Icon(Icons.settings_remote_outlined), label: "Receiver")
      ],
      currentIndex: selectedIndex,
      onTap: onItemTapped,
    );
  }
}
