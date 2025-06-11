import 'package:aviation_app/core/constant/logos.dart';
import 'package:aviation_app/core/constant/padding.dart';
import 'package:aviation_app/core/theme/theme_extension/app_colors.dart';
import 'package:aviation_app/core/utils/utils.dart';
import 'package:aviation_app/features/create_screen/create_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:slider_button/slider_button.dart';

class OnboardingScreen extends StatelessWidget {
  const OnboardingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return CreateScreen(
      child: Padding(
        padding: AppPadding.screenHorizontal,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Spacer(),
            Align(
              alignment: Alignment.center,
              child: SvgPicture.asset(AppLogo.splashLogo),
            ),
            Spacer(),
            Text("Fly smarter.\nLearn faster", style: textTheme.headlineMedium),
            SizedBox(height: 24.h),
            Text(
              "Access real-time aviation tools, AI-powered guidance, "
              "and expert resources — designed to help you master "
              "the skies with confidence.",
              style: textTheme.bodyMedium?.copyWith(color: Color(0xff919EAB)),
            ),
            SizedBox(height: 48.h),
            Row(
              children: [
                Expanded(
                  child: SliderButton(
                    action: () async {
                      return false;
                    },
                    label: Text(
                      "Next",
                      style: textTheme.bodyMedium?.copyWith(
                        color: Color(0xff919EAB),
                      ),
                    ),
                    icon: Icon(Icons.arrow_forward),
                    backgroundColor: AppColors.surface,
                    width: 218.w,
                    height: 58.h,
                    alignLabel: Alignment.center,
                    buttonColor: Color(0xff3762E4),
                    trailing: Padding(
                      padding: EdgeInsets.only(right: 12.w),
                      child: Icon(Icons.double_arrow, color: Color(0xff919EAB)),
                    ),
                  ),
                ),
                Utils.primaryButton(
                  backgroundColor: AppColors.surface,
                  borderRadius: BorderRadius.circular(100.r),
                  width: 109.w,
                  height: 58.h,
                  onPressed: () {},
                  text: "Skip",
                ),
              ],
            ),
            Spacer(),
          ],
        ),
      ),
    );
  }
}
