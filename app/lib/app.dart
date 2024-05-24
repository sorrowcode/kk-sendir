import 'package:remote_control/components/set_credentials.dart';
import 'package:remote_control/pages/home_page.dart';
import 'package:remote_control/pages/settings.dart';
import 'package:remote_control/components/tab_manager/add_device_tab.dart';
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
        '/addDevices':(context) => AddDevicesTab(deviceItems: const [], onTap: (String name) {},),
        '/set_credentials':(context) => const SetCredentialsScreen(),
      },
    );
  }
}
