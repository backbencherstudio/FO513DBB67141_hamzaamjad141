import 'package:aviation_app/core/utils/common_widget/common_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../../core/theme/theme_extension/app_colors.dart';

class BuildTextFiled extends HookWidget {
  const BuildTextFiled({super.key});

  @override
  Widget build(BuildContext context) {
    TextTheme textTheme = Theme.of(context).textTheme;

    // Create an animation controller using hooks
    final animationController = useAnimationController(
      duration: const Duration(milliseconds: 300),
    );

    // Create a scale animation
    final scaleAnimation = Tween<double>(begin: 0.8, end: 1.0).animate(
      CurvedAnimation(parent: animationController, curve: Curves.easeInOut),
    );

    // Start the animation when the widget mounts, and handle cleanup
    useEffect(() {
      animationController.forward();
      return null;
    }, const []);

    return ScaleTransition(
      scale: scaleAnimation,
      child: Container(
        padding: EdgeInsets.all(1),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Colors.white,
              Colors.transparent,
              Colors.white,
              Colors.transparent,
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            stops: const [0.0, 0.05, 0.7, 1.0],
          ),
          borderRadius: BorderRadius.circular(12.r),
        ),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12.r),
            color: AppColors.secondary,
          ),
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12.r),
              color: Colors.white10,
            ),
            child: Container(
              height: 50.h, // Fixed height to match the image
              padding: EdgeInsets.symmetric(horizontal: 16.w),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    AppColors.primary.withValues(alpha: 0.08),
                    Color(0xff23293D).withValues(alpha: 0.7),
                    Color(0xff23293D).withValues(alpha: 0.7),
                    AppColors.primary.withValues(alpha: 0.08),
                  ],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  stops: const [
                    0.0,
                    0.25,
                    0.75,
                    1.0,
                  ], // Gradual stops for smoothness
                ),
                borderRadius: BorderRadius.circular(12.r),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Expanded(
                    child: TextField(
                      decoration: InputDecoration(
                        filled: false,
                        hintText: 'Type your question here...',
                        hintStyle: textTheme.bodyMedium!.copyWith(
                          color: Colors.white,
                          fontSize: 14.sp,
                        ),
                        border: InputBorder.none,
                        contentPadding: EdgeInsets.zero,
                      ),
                      style: textTheme.bodyMedium!.copyWith(
                        color: Colors.white,
                        fontSize: 14.sp,
                      ),
                      textAlign: TextAlign.left,
                    ),
                  ),
                  SizedBox(width: 5.w),
                  GestureDetector(
                    onTap: () {},
                    child: CommonWidget.secondaryButton(
                      child: SvgPicture.asset('assets/icons/send.svg'),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
