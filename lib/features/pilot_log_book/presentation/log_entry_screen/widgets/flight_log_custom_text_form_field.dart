import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../core/theme/theme_extension/app_colors.dart';

class FlightLogCustomTextField extends StatelessWidget{
  final String label;
  final String hint;
  final TextEditingController controller;
  final FocusNode? focusNode;
  final Widget? suffixIcon;
  const FlightLogCustomTextField({super.key,
  required this.label,
    required this.hint,
    required this.controller,
    this.focusNode,
    this.suffixIcon
  });

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
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
            label,
            style: textTheme.bodySmall?.copyWith(
              color: AppColors.secondaryTextColor,
            ),
          ),
          TextFormField(
            style: textTheme.bodySmall,
            controller: controller,
            focusNode: focusNode,
            onTapOutside: (_)=>focusNode?.unfocus(),
            decoration: InputDecoration(hintText: hint),
          ),
        ],
      ),
    );
  }
}