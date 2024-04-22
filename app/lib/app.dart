import 'package:Remote_Control/pages/home_page.dart';
import 'package:Remote_Control/pages/settings.dart';
import 'package:Remote_Control/theme/theme.dart';
import 'package:flutter/material.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      themeMode: ThemeMode.light,
      theme: lightMode,
      darkTheme: darkMode,
      routes: {
        '/': (context) => MyHomePage(),
        '/settings': (context) => const Settings(),
      },
    );
  }
}
