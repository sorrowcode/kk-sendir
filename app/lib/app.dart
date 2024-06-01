import 'package:flutter_blue_plus/flutter_blue_plus.dart';
import 'package:remote_control/components/add_devices/set_credentials.dart';
import 'package:remote_control/pages/home_page.dart';
import 'package:remote_control/pages/settings.dart';
import 'package:remote_control/components/add_devices/add_device_tab.dart';
import 'package:remote_control/theme/theme.dart';
import 'package:flutter/material.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      themeMode: ThemeMode.system,
      theme: lightMode,
      darkTheme: darkMode,
      routes: {
        '/': (context) => const MyHomePage(),
        '/settings': (context) => const Settings(),
        '/addDevices': (context) => AddDevicesTab(
              deviceItems: const [],
              onTap: (String name, remoteID) {},
            ),
        '/set_credentials': (context) => SetCredentialsScreen(
            device: BluetoothDevice(remoteId: const DeviceIdentifier('334')),
            deviceItems: const [],
            onTap: (String name, remoteID) {},
            selMode: 0,
            remoteID: const DeviceIdentifier('334')),
      },
    );
  }
}
