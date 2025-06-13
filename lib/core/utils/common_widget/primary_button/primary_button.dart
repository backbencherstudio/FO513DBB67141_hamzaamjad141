import 'package:aviation_app/core/theme/theme_extension/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class PrimaryButton extends StatelessWidget {
final bool isSecondary;
final String bodyText;
final bool isActive;
final VoidCallback onTap;

  const PrimaryButton({super.key, this.isSecondary = false, required this.bodyText, this.isActive = true, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: isActive ? onTap : null,
      child: Container(
        height: 54.h,
        padding: EdgeInsets.all(12.5.r),
        decoration: BoxDecoration(
          color: (!isSecondary && isActive) ? AppColors.primary : Color(0xff1D1F2C),
          borderRadius: BorderRadius.circular(8.r),
          border: Border.all(color: (!isSecondary && isActive) ? Color(0xff4E75FF) : Color(0xff262A41),),
          image: DecorationImage(
            image: AssetImage('assets/primary_button/dot_circle.png',),
          ),
        ),
        child: Center(child: Text(bodyText,style: Theme.of(context).textTheme.bodyLarge?.copyWith(
          color: isActive ? Colors.white : Color(0xff777980),
        ),)),
      ),
    );
  }
}
