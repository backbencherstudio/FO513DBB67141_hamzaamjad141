import 'package:flutter/material.dart';
import '../theme_extension/app_colors.dart';

class CustomDatePickerTheme {
  static DatePickerThemeData datePickerTheme = DatePickerThemeData(
    backgroundColor: Colors.white,
    headerBackgroundColor: AppColors.primary,
    headerForegroundColor: Colors.white,
    dayForegroundColor: MaterialStateColor.resolveWith((states) {
      if (states.contains(MaterialState.selected)) {
        return Colors.white;
      } else if (states.contains(MaterialState.disabled)) {
        return Colors.grey;
      }
      return AppColors.primary;
    }),
    dayBackgroundColor: MaterialStateColor.resolveWith((states) {
      if (states.contains(MaterialState.selected)) {
        return AppColors.primary;
      } else if (states.contains(MaterialState.disabled)) {
        return Colors.grey.shade200;
      }
      return Colors.transparent;
    }),
    todayForegroundColor: WidgetStatePropertyAll(AppColors.primary),
    todayBackgroundColor: WidgetStatePropertyAll(
      AppColors.primary.withOpacity(0.1),
    ),
    yearForegroundColor: MaterialStateColor.resolveWith((states) {
      return states.contains(MaterialState.selected)
          ? Colors.white
          : AppColors.primary;
    }),
    yearBackgroundColor: MaterialStateColor.resolveWith((states) {
      return states.contains(MaterialState.selected)
          ? AppColors.primary
          : Colors.transparent;
    }),
  );
}
