import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/theme/theme_extension/app_colors.dart';

class CircleShadowBox extends StatefulWidget {
  final Widget child;
  final Widget replacement;

  const CircleShadowBox({
    super.key,
    required this.child,
    required this.replacement,
  });

  @override
  State<CircleShadowBox> createState() => _CircleShadowBoxState();
}

class _CircleShadowBoxState extends State<CircleShadowBox> {
  bool _tapped = false;

  @override
  Widget build(BuildContext context) {
    if (_tapped) return widget.replacement;

    return GestureDetector(
      onTap: () => setState(() => _tapped = true),
      child: Column(
        children: [
          Container(
            width: 132.h,
            height: 132.h,
            margin: EdgeInsets.all(32.h),
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: const Color(0xFF1D1F2C),
              borderRadius: BorderRadius.circular(7343.r),
              boxShadow: [
                BoxShadow(
                  color: AppColors.primary.withValues(alpha: 0.5),
                  offset: const Offset(0, 2.938),
                  blurRadius: 20.r,
                  spreadRadius: 4.r,
                ),
              ],
            ),
            child: widget.child,
          ),
        ],
      ),
    );
  }
}
