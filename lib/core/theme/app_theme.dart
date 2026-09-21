import 'package:flutter/material.dart';

class AppTheme {
  static const Color primaryColor = Color(0xFF4A00E0); // بنفسجي ملكي
  static const Color secondaryColor = Color(0xFFFF007F); // مرجاني / بينك نيون
  static const Color backgroundColor = Color(0xFFF3F5F9);
  static const Color lightBgColor = Color(0xFFE8EEF2);
  static const Color successColor = Color(0xFF00C853);
  static const Color warningColor = Color(0xFFFFB300);

  static ThemeData get lightTheme {
    return ThemeData(
      scaffoldBackgroundColor: backgroundColor,
      fontFamily: 'Tajawal',
      colorScheme: const ColorScheme.light(
        primary: primaryColor,
        secondary: secondaryColor,
      ),
    );
  }
}
