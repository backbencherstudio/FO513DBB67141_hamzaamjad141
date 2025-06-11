import 'package:flutter/material.dart';

class AppColors {
  static ColorScheme darkColorScheme = ColorScheme(
    brightness: Brightness.dark,
    primary: Color(0xff3762E4),
    onPrimary: Color(0xffFFFFFF),
    secondary: Color(0xff23293D),
    onSecondary: Color(0xffF9FAFB),
    error: Color.fromRGBO(235, 61, 77, 0.09),
    onError: Color(0xffEB3D4D),
    surface: Color(0xff161721),
    onSurface: Color(0xffF9FAFB),
  );
  static const Color primary = Color(0xff090C20);
  static const Color onPrimary = Color(0xffFFFFFF);
  static const Color secondary = Color(0xff23293D);
  static const Color onSecondary = Color(0xffF9FAFB);
  static const Color error = Color.fromRGBO(235, 61, 77, 0.09);
  static const Color onError = Color(0xffEB3D4D);
  static const Color surface = Color(0xff161721);
  static const Color onSurface = Color(0xffF9FAFB);
  static const Color bottomNavBarBackground = Color(0xff212432);
}
