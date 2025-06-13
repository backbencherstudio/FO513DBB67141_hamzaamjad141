import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../theme_extension/app_colors.dart';

class AppInputDecorationTheme {
  static InputDecorationTheme inputDecorationTheme = InputDecorationTheme(
   filled: true,
   fillColor: Color(0xff161721),
    hintStyle: TextStyle(color: Color(0xff777980)),
    prefixIconColor: Color(0xffffffff),
    suffixIconColor: Color(0xffffffff),
    errorStyle: TextStyle(color: AppColors.error),
    border: OutlineInputBorder(
      borderSide: BorderSide(color: Color(0xff161721)),
      borderRadius: BorderRadius.circular(8.r),
    ),
    enabledBorder: OutlineInputBorder(
      borderSide: BorderSide(color: Color(0xff161721)),
      borderRadius: BorderRadius.circular(8.r),
    ),
    focusedBorder: OutlineInputBorder(
      borderSide: BorderSide(color: Color(0xff161721) ),
      borderRadius: BorderRadius.circular(8.r),
    ),
    disabledBorder: OutlineInputBorder(
      borderSide: BorderSide(color: Color(0xff161721)),
      borderRadius: BorderRadius.circular(8.r),
    ),
    errorBorder: OutlineInputBorder(
      borderSide: BorderSide(color: Color(0xff161721)),
      borderRadius: BorderRadius.circular(8.r),
    ),
  );
}
