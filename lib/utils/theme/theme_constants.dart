import 'package:flutter/material.dart';

ThemeData lightTheme = ThemeData(
  colorScheme: ColorScheme.fromSeed(
    seedColor: const Color(0xff0a228c),
    brightness: Brightness.light,
    surface: Colors.white,
    secondary: const Color(0xffff9500),
  ),
  primaryColor: const Color(0xff0a228c),
  scaffoldBackgroundColor: const Color(0xfff5f5f5),
);

ThemeData darkTheme = ThemeData(
  useMaterial3: true,
  colorScheme: ColorScheme.fromSeed(
    seedColor: const Color(0xffff9500),
    brightness: Brightness.dark,
    surface: const Color.fromARGB(100, 38, 38, 38),
    onSurface: Colors.white,
    secondary: const Color(0xff0a228c),
  ),
  primaryColor: const Color(0xffFF9500),
  scaffoldBackgroundColor: Colors.black38,
);
