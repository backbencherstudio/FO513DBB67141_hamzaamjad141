import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../core/theme/theme_extension/app_colors.dart';
class CustomTextField extends StatelessWidget {
  const CustomTextField({
    super.key,
    required this.textTheme,
    required this.labelName,
    this.controller, required this.hintText,
    this.enabled = true,
  });

  final TextTheme textTheme;
  final String labelName;
  final String hintText;
  final TextEditingController? controller;
  final bool enabled;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 19.w, vertical: 13.h),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(8.r),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            labelName,
            style: textTheme.bodyMedium!.copyWith(
              color: AppColors.secondaryTextColor,
            ),
          ),
          TextFormField(
            enabled: enabled,
            controller: controller,
            decoration: InputDecoration(
              border: OutlineInputBorder(),
              hintText: hintText,
            ),
          ),
        ],
      ),
    );
  }
}