import 'package:flutter/cupertino.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../core/theme/theme_extension/app_colors.dart';

Widget buildTypingIndicator() {
  return Container(
    padding: EdgeInsets.all(12.w),
    decoration: BoxDecoration(
      color: AppColors.secondary.withValues(alpha: 0.1),
      borderRadius: BorderRadius.only(
        topLeft: Radius.circular(16.r),
        bottomLeft: Radius.circular(4.r),
        bottomRight: Radius.circular(16.r),
        topRight: Radius.circular(16.r),
      ),
    ),
    child: Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        _buildDot(),
        SizedBox(width: 4.w),
        _buildDot(delay: 200.ms),
        SizedBox(width: 4.w),
        _buildDot(delay: 400.ms),
      ],
    ),
  ).animate().fadeIn(duration: 300.ms);
}
Widget _buildDot({Duration delay = Duration.zero}) {
  return Container(
    width: 8.w,
    height: 8.w,
    decoration: const BoxDecoration(
      color: AppColors.primary,
      shape: BoxShape.circle,
    ),
  ).animate().scale(duration: 600.ms, delay: delay, curve: Curves.easeInOut);
}
