import 'package:flutter/material.dart';


class AppTheme {
  static const Color primaryColor = Color(0xFFFE9F21);
  static const Color secondaryColor = Color.fromARGB(255, 230, 222, 2);
  static const Color accentColor = Color(0xFFF23D32);
  static const Color backgroundColor = Color(0xFFF5F5F5);
  static const Color textColor = Color(0xFF1F1F1F);

  static ThemeData lightTheme = ThemeData(
    useMaterial3: true,
    brightness: Brightness.light,

    colorScheme: ColorScheme.light(
      primary: primaryColor,
      secondary: secondaryColor,
      tertiary: accentColor,
      background: backgroundColor,
      surface: const Color.fromARGB(255, 255, 255, 255),
      onPrimary: const Color.fromARGB(255, 255, 255, 255),
      onSecondary: const Color.fromARGB(255, 255, 255, 255),
      onBackground: textColor,
      onSurface: textColor,
    ),

    scaffoldBackgroundColor: const Color.fromARGB(255, 255, 255, 255),
    fontFamily: 'Roboto',

    textTheme: const TextTheme(
      headlineLarge: TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
      headlineMedium: TextStyle(fontSize: 24, fontWeight: FontWeight.w600),
      bodyLarge: TextStyle(fontSize: 16),
      bodyMedium: TextStyle(fontSize: 14),
      labelLarge: TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
    ),

    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: primaryColor,
        foregroundColor: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
      ),
    ),

    appBarTheme: const AppBarTheme(
      backgroundColor: Color.fromARGB(255, 244, 169, 6),
      foregroundColor: textColor,
      elevation: 0,
      centerTitle: true,
    ),
  );
}