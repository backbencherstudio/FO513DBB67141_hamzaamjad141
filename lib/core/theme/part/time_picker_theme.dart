import 'package:flutter/material.dart';
import '../theme_extension/app_colors.dart';

class CustomTimePickerTheme {
  static TimePickerThemeData timePickerTheme = TimePickerThemeData(
    hourMinuteColor: MaterialStateColor.resolveWith((states) {
      return states.contains(MaterialState.selected)
          ? AppColors.primary
          : Colors.white;
    }),
    hourMinuteTextColor: MaterialStateColor.resolveWith((states) {
      return states.contains(MaterialState.selected)
          ? Colors.white
          : AppColors.primary;
    }),
    dayPeriodColor: MaterialStateColor.resolveWith((states) {
      return states.contains(MaterialState.selected)
          ? AppColors.primary
          : Colors.white;
    }),
    dayPeriodTextColor: MaterialStateColor.resolveWith((states) {
      return states.contains(MaterialState.selected)
          ? Colors.white
          : AppColors.primary;
    }),
    backgroundColor: Colors.white,
    dialHandColor: AppColors.primary,
    helpTextStyle: TextStyle(color: Colors.white),
  );
}
