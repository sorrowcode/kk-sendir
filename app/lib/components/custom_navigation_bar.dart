import 'package:app/components/tab_manager/tab_manager.dart';
import 'package:flutter/material.dart';

class CustomNavigationBar extends StatefulWidget {
  const CustomNavigationBar({super.key});

  @override
  State<CustomNavigationBar> createState() => _CustomNavigationBarState();
}

class _CustomNavigationBarState extends State<CustomNavigationBar> {
  @override
  Widget build(BuildContext context) {
    void onTabTabbed(int tab) {
      setState(() {
        TabManager().index = tab;
      });
    }

    ;
    return BottomAppBar(
      color: Theme.of(context).colorScheme.inversePrimary,
      shape: const CircularNotchedRectangle(),
      child: const Row(

      ),
    );
  }
}
