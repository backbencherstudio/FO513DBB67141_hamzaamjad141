import 'package:aviation_app/core/theme/theme_extension/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class PrimaryButton extends StatelessWidget {
  final bool isSecondary;
  final String bodyText;
  final bool isActive;
  final VoidCallback onTap;
  final bool dots;
  final TextStyle? textStyle;
  final EdgeInsets? padding;
  final Color? backgroundColor;
  final Color? borderColor;

  const PrimaryButton({
    super.key,
    this.isSecondary = false,
    required this.bodyText,
    this.isActive = true,
    required this.onTap,
    this.dots = true,
    this.textStyle,
    this.padding,
    this.backgroundColor,
    this.borderColor,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: isActive ? onTap : null,
      child: Container(
        height: 54.h,
        padding:
            padding ?? EdgeInsets.symmetric(vertical: 12.h, horizontal: 34.w),
        decoration: BoxDecoration(
          color:
              backgroundColor ??
              ((!isSecondary && isActive)
                  ? AppColors.primary
                  : Color(0xff1D1F2C)),
          borderRadius: BorderRadius.circular(8.r),
          border: Border.all(
            color:
                borderColor ??
                ((!isSecondary && isActive)
                    ? Color(0xff4E75FF)
                    : Color(0xff262A41)),
          ),
          image: dots
              ? DecorationImage(
                  image: AssetImage('assets/primary_button/dot_circle.png'),
                )
              : null,
        ),
        child: Center(
          child: FittedBox(
            child: Text(
              bodyText,
              style:
                  textStyle ??
                  Theme.of(context).textTheme.bodyLarge?.copyWith(
                    color: isActive
                        ? Colors.white
                        : AppColors.deActiveTextColor,
                    //Color(0xff777980),
                  ),
              maxLines: 1,
            ),
          ),
        ),
      ),
    );
  }
}



