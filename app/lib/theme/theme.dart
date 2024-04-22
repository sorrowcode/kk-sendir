import 'package:flutter/material.dart';

ThemeData lightMode = ThemeData(
  brightness: Brightness.light,
  appBarTheme: const AppBarTheme(
    backgroundColor: Color(0xFFd4d4d4),
  ),
  bottomNavigationBarTheme: const BottomNavigationBarThemeData(
    backgroundColor: Color(0xFFd4d4d4),
  ),
  colorScheme: const ColorScheme.light(
    outline: Color.fromARGB(255, 85, 155, 117),
    background: Color(0xFFece8e4),
    onBackground: Color(0xFF000000),
    primary: Color(0xFF4cbdb7),
    onPrimary: Color(0xFF000000),
    secondary: Color(0xFF0d0363),
    onSecondary: Color(0xFFece8e4),
    tertiary: Color(0xFF4b109e),
    onTertiary: Color(0xFFece8e4),
    surface: Color(0xFFece8e4),
    onSurface: Color(0xFF000000),
    surfaceVariant: Color(0xFF79cda0),
    onSurfaceVariant: Color(0xFFf37777),
    error: Brightness.light == Brightness.light ? Color(0xffB3261E) : Color(0xffF2B8B5),
    onError: Brightness.light == Brightness.light ? Color(0xffFFFFFF) : Color(0xff601410),
  ),
);

ThemeData darkMode = ThemeData(
  brightness: Brightness.dark,
  appBarTheme: const AppBarTheme(
    backgroundColor: Color(0xFF2b2b2b),
  ),
  bottomNavigationBarTheme: const BottomNavigationBarThemeData(
    backgroundColor: Color(0xFF2b2b2b),
  ),
  buttonTheme: const ButtonThemeData(
    buttonColor: Color(0xFF42b3ad),
    splashColor: Colors.transparent,
  ),
  colorScheme: const ColorScheme.dark(
    outline: Color(0xFF305d44),
    background: Color(0xFF191515),
    onBackground: Color(0xFFffffff),
    primary: Color(0xFF42b3ad),
    onPrimary: Color(0xFF1b1713),
    secondary: Color(0xFFa69cfc),
    onSecondary: Color(0xFF1b1713),
    tertiary: Color(0xFF9c61ef),
    onTertiary: Color(0xFF1b1713),
    surface: Color(0xFF191515),
    onSurface: Color(0xFFffffff),
    surfaceVariant: Color(0xFF278d56),
    onSurfaceVariant: Color(0xFF3b0d0d),
    error: Brightness.dark == Brightness.light ? Color(0xffB3261E) : Color(0xffF2B8B5),
    onError: Brightness.dark == Brightness.light ? Color(0xffFFFFFF) : Color(0xff601410),
  )
);
