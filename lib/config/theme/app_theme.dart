
import 'package:flutter/material.dart';

class AppTheme {

  final bool isDarkMode;

  AppTheme({required this.isDarkMode});

  ThemeData getTheme() => ThemeData(
    useMaterial3: true,
    colorSchemeSeed: const Color(0xff2862F5),
    brightness: isDarkMode
      ? Brightness.dark
      : Brightness.light
  );
  
}