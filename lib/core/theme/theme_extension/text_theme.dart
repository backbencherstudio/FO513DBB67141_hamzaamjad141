import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter/material.dart';

import 'app_colors.dart';

class AppTextTheme {
  static TextTheme darkTextTheme = TextTheme(
    headlineLarge: GoogleFonts.poppins(
      fontSize: 28.sp,
      fontWeight: FontWeight.w700,
    ),
    headlineMedium: GoogleFonts.poppins(
      fontSize: 26.sp,
      fontWeight: FontWeight.w400,
    ),
    headlineSmall: GoogleFonts.poppins(
      fontSize: 24.sp,
      fontWeight: FontWeight.w400,

    ),
    titleLarge: GoogleFonts.poppins(
      fontSize: 22.sp,
      fontWeight: FontWeight.w600,
    ),
    titleMedium: GoogleFonts.poppins(
      fontSize: 20.sp,
      fontWeight: FontWeight.w600,
    ),
    titleSmall: GoogleFonts.poppins(
      fontSize: 18.sp,
      fontWeight: FontWeight.w600,
    ),

    bodyLarge: GoogleFonts.poppins(
      fontSize: 18.sp,
      fontWeight: FontWeight.w400,
    ),
    bodyMedium: GoogleFonts.poppins(
      fontSize: 16.sp,
      fontWeight: FontWeight.w400,
    ),
    bodySmall: GoogleFonts.poppins(
      fontSize: 14.sp,
      fontWeight: FontWeight.w400,
    ),

    labelLarge: GoogleFonts.poppins(
      fontSize: 14.sp,
      fontWeight: FontWeight.w500,
    ),
    labelMedium: GoogleFonts.poppins(
      fontSize: 12.sp,
      fontWeight: FontWeight.w500,
    ),
    labelSmall: GoogleFonts.poppins(
      fontSize: 11.sp,
      fontWeight: FontWeight.w400,
    ),
  );
}
