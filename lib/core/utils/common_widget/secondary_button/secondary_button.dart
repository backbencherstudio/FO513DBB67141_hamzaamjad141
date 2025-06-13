import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../theme/theme_extension/app_colors.dart';

class SecondaryButtonWidget extends StatelessWidget {
  final Widget child;
  final VoidCallback? onTap;

  const SecondaryButtonWidget({
    super.key,
    required this.child,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              AppColors.onPrimary,
              AppColors.onPrimary.withAlpha(100),
              AppColors.onPrimary.withAlpha(4),
              AppColors.onPrimary.withAlpha(4),
            ],
          ),
        ),
        child: Container(
          margin: EdgeInsets.all(1.r),
          padding: EdgeInsets.all(10.r),
          decoration: BoxDecoration(
            color: AppColors.secondary,
            shape: BoxShape.circle,
          ),
          child: child,
        ),
      ),
    );
  }
}
