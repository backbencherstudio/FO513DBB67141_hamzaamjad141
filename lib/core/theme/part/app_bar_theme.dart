import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

import '../theme_extension/app_colors.dart';

class AppAppBarTheme {
  static AppBarTheme lightAppBarTheme = AppBarTheme(
    backgroundColor: AppColors.onPrimary,
    actionsPadding: EdgeInsets.all(10),
    titleTextStyle: GoogleFonts.roboto(
      textStyle: TextStyle(
        color: AppColors.primary,
        fontSize: 16.sp,
        fontWeight: FontWeight.w600,
      ),
    ),
  );
}
