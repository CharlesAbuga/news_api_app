import 'package:flutter/material.dart';

ThemeData lightTheme = ThemeData(
  useMaterial3: true,
  colorScheme: const ColorScheme.light(
    surface: Colors.white,
    onSurface: Colors.black,
    primary: Colors.orange,
    onPrimary: Colors.black,
    secondary: Color.fromARGB(255, 150, 91, 3),
    onSecondary: Colors.white,
    tertiary: Colors.black,
    error: Colors.red,
    outline: Colors.white,
    inverseSurface: Color.fromARGB(255, 220, 147, 36),
  ),
);

ThemeData darkTheme = ThemeData(
  useMaterial3: true,
  colorScheme: const ColorScheme.dark(
    surface: Colors.black,
    onSurface: Colors.white,
    primary: Colors.orange,
    onPrimary: Colors.black,
    secondary: Color.fromARGB(255, 150, 91, 3),
    onSecondary: Colors.white,
    tertiary: Colors.black,
    error: Colors.red,
    outline: Colors.black,
    inverseSurface: Colors.orange,
  ),
);
