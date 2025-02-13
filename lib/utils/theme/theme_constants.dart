import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

ThemeData lightTheme = ThemeData(
  colorScheme: ColorScheme.fromSeed(
    seedColor: const Color(0xff0a228c),
    brightness: Brightness.light,
    surface: Colors.white,
    secondary: const Color(0xffff9500),
  ),
  textTheme: TextTheme(
    headlineLarge: GoogleFonts.poppins(
      fontSize: 32.sp,
      fontWeight: FontWeight.bold,
      color: Colors.black,
    ),
    headlineSmall: GoogleFonts.roboto(
      fontSize: 24.sp,
      fontWeight: FontWeight.w500,
      color: Colors.black54,
    ),
    bodyLarge: TextStyle(
      fontSize: 18.sp,
      color: Colors.black,
    ),
    bodySmall: TextStyle(
      fontSize: 14.sp,
      color: Colors.grey,
    ),
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
  textTheme: TextTheme(
    headlineLarge: GoogleFonts.poppins(
      fontSize: 32.sp,
      fontWeight: FontWeight.bold,
      color: Colors.white,
    ),
    headlineSmall: GoogleFonts.roboto(
      fontSize: 24.sp,
      fontWeight: FontWeight.w500,
      color: Colors.white70,
    ),
    bodyLarge: TextStyle(
      fontSize: 18.sp,
      color: Colors.white,
    ),
    bodySmall: TextStyle(
      fontSize: 14.sp,
      color: Colors.grey,
    ),
  ),
  primaryColor: const Color(0xffFF9500),
  scaffoldBackgroundColor: Colors.black38,
);
