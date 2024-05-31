import 'package:flutter/material.dart';
import 'package:remote_control/pages/home_page.dart';

class ReceiverTab extends StatefulWidget {
  const ReceiverTab({super.key});

  @override
  State<ReceiverTab> createState() => _ReceiverTabState();
}

class _ReceiverTabState extends State<ReceiverTab> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          Text(MyHomePage.selectedDevice),
        ],
      ),
    );
  }
}
