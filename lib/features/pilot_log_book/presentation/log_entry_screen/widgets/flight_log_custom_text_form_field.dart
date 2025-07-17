import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../core/theme/theme_extension/app_colors.dart';

class FlightLogCustomTextField extends StatelessWidget{
  final String label;
  final String hint;
  final TextEditingController controller;
  final FocusNode? focusNode;
  final Widget? suffixIcon;
  final TextInputType? keyboardType;
  final bool enabled;
  final Function? onTap;
  const FlightLogCustomTextField({super.key,
  required this.label,
    required this.hint,
    required this.controller,
    this.focusNode,
    this.suffixIcon,
    this.keyboardType,
    this.enabled = true,
    this.onTap,
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
      child: GestureDetector(
        onTap: onTap != null ? (){onTap!();} : null,
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
              onTap: onTap != null ?  () async {
                await onTap!();
              } : null,
              enabled: enabled,
              keyboardType: keyboardType,
              style: textTheme.bodySmall,
              controller: controller,
              focusNode: focusNode,
              onTapOutside: (_)=>focusNode?.unfocus(),
              decoration: InputDecoration(hintText: hint),
            ),
          ],
        ),
      ),
    );
  }
}