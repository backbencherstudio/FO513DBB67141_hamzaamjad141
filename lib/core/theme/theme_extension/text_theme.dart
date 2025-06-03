import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter/material.dart';

import 'app_colors.dart';

class AppTextTheme {
  static TextTheme darkTextTheme = TextTheme(
    headlineLarge: GoogleFonts.roboto(
      fontSize: 28.sp,
      fontWeight: FontWeight.w700,
    ),
    headlineMedium: GoogleFonts.roboto(
      fontSize: 26.sp,
      fontWeight: FontWeight.w700,
    ),
    headlineSmall: GoogleFonts.roboto(
      fontSize: 24.sp,
      fontWeight: FontWeight.w600,
    ),
    titleLarge: GoogleFonts.roboto(
      fontSize: 22.sp,
      fontWeight: FontWeight.w600,
    ),
    titleMedium: GoogleFonts.roboto(
      fontSize: 20.sp,
      fontWeight: FontWeight.w600,
    ),
    titleSmall: GoogleFonts.roboto(
      fontSize: 18.sp,
      fontWeight: FontWeight.w600,
    ),
    bodyLarge: GoogleFonts.roboto(
      fontSize: 16.sp,
      fontWeight: FontWeight.w400,
    ),
    bodyMedium: GoogleFonts.roboto(
      fontSize: 14.sp,
      fontWeight: FontWeight.w400,
    ),
    bodySmall: GoogleFonts.roboto(
      fontSize: 12.sp,
      fontWeight: FontWeight.w400,
    ),
    labelLarge: GoogleFonts.roboto(
      fontSize: 14.sp,
      fontWeight: FontWeight.w500,
    ),
    labelMedium: GoogleFonts.roboto(
      fontSize: 12.sp,
      fontWeight: FontWeight.w500,
    ),
    labelSmall: GoogleFonts.roboto(
      fontSize: 11.sp,
      fontWeight: FontWeight.w400,
    ),
  );
}
