import 'package:flutter/material.dart';

class AppTheme {
  static const Color primaryColor = Color(0xFF00F2FE);
  static const Color secondaryColor = Color(0xFF4FACFE);
  static const Color backgroundColor = Color(0xFF0B0F19);
  static const Color surfaceColor = Color(0xFF151B2B);
  static const Color dangerColor = Color(0xFFFE005C);

  static ThemeData get darkTheme {
    return ThemeData(
      brightness: Brightness.dark,
      primaryColor: primaryColor,
      scaffoldBackgroundColor: backgroundColor,
      colorScheme: const ColorScheme.dark(
        primary: primaryColor,
        secondary: secondaryColor,
        surface: surfaceColor,
        error: dangerColor,
      ),
      fontFamily: 'Tajawal', // تأكد من إضافة الخط في pubspec.yaml
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: primaryColor,
          foregroundColor: Colors.black,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          padding: const EdgeInsets.symmetric(vertical: 18),
        ),
      ),
    );
  }
}
