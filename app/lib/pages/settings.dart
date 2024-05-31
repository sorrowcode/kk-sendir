import 'package:remote_control/pages/home_page.dart';
import 'package:flutter/material.dart';

class Settings extends StatefulWidget {
  const Settings({super.key});

  @override
  State<Settings> createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  bool _isOn = false;
  @override
  Widget build(BuildContext context) {
    final WidgetStateProperty<Color?> trackColor =
        WidgetStateProperty.resolveWith<Color?>((Set<WidgetState> states) {
      // Track color when the switch is selected.
      if (states.contains(WidgetState.selected)) {
        return Colors.amber;
      }
      // Otherwise return null to set default track color
      // for remaining states such as when the switch is
      // hovered, focused, or disabled.
      return null;
    });

    final WidgetStateProperty<Color?> overlayColor =
        WidgetStateProperty.resolveWith<Color?>(
      (Set<WidgetState> states) {
        // Material color when switch is selected.
        if (states.contains(WidgetState.selected)) {
          return Colors.amber.withOpacity(0.54);
        }
        // Material color when switch is disabled.
        if (states.contains(WidgetState.disabled)) {
          return Colors.grey.shade400;
        }
        // Otherwise return null to set default material color
        // for remaining states such as when the switch is
        // hovered, or focused.
        return null;
      },
    );

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).appBarTheme.backgroundColor,
        leading: IconButton(
          onPressed: () {
            Navigator.of(context).pop(MaterialPageRoute(
              builder: (context) => const MyHomePage(),
            ));
          },
          icon: const Icon(Icons.arrow_back),
        ),
        title: const Text('Settings'),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Switch(
              value: _isOn,
              overlayColor: overlayColor,
              trackColor: trackColor,
              onChanged: (bool value) {
                setState(() {
                  _isOn = value;
                });
              }),
        ],
      ),
    );
  }
}
