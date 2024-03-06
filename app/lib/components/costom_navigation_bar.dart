import 'package:flutter/material.dart';

class CustomNavigationBar extends StatelessWidget {
  const CustomNavigationBar({super.key});

  @override
  Widget build(BuildContext context) {
    return BottomAppBar(
      color: const Color.fromARGB(255, 84, 101, 131),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.settings_remote),
            color: Colors.black,
            hoverColor: const Color.fromRGBO(50, 67, 88, 0.5),
            highlightColor: const Color.fromRGBO(50, 67, 88, 1),
            tooltip: "Emitter",
          ),
          const SizedBox(
            width: 30,
          ),
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.settings_remote_outlined),
            color: Colors.black,
            hoverColor: const Color.fromRGBO(50, 67, 88, 0.5),
            highlightColor: const Color.fromRGBO(50, 67, 88, 1),
            tooltip: 'Receiver',
          ),
        ],
      ),
    );
  }
}
