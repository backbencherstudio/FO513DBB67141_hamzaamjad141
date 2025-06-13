import 'package:aviation_app/features/onboarding/riverpod/onboarding_notifier.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:slider_button/slider_button.dart';

import '../../../../core/constant/padding.dart';
import '../../../../core/routes/route_name.dart';
import '../../../../core/theme/theme_extension/app_colors.dart';
import '../../../../core/utils/utils.dart';

class OnboardingFooter extends StatelessWidget {
  const OnboardingFooter({super.key, required this.tabBarController});

  final TabController tabBarController;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Padding(
      padding: AppPadding.screenHorizontal,
      child: Column(
        children: [
          Row(
            children: [
              Expanded(
                child: Consumer(
                  builder: (_, ref, _) {
                    return SliderButton(
                      action: () async {
                        if (tabBarController.index < 2) {
                          ref
                              .read(onboardingProvider.notifier)
                              .onSlideToNextOnboarding(
                                tabBarController.index + 1,
                              );
                          tabBarController.animateTo(
                            tabBarController.index + 1,
                          );
                        }
                        return false;
                      },
                      label: Text(
                        "Next",
                        style: textTheme.bodyMedium?.copyWith(
                          color: Color(0xff919EAB),
                        ),
                      ),
                      buttonSize: 58.h,
                      icon: Icon(Icons.arrow_forward),
                      backgroundColor: AppColors.surface,
                      width: 218.w,
                      height: 58.h,
                      alignLabel: Alignment.center,
                      buttonColor: Color(0xff3762E4),
                      trailing: Padding(
                        padding: EdgeInsets.only(right: 12.w),
                        child: Icon(
                          Icons.double_arrow,
                          color: Color(0xff919EAB),
                        ),
                      ),
                    );
                  },
                ),
              ),
              Utils.primaryButton(
                backgroundColor: AppColors.surface,
                borderRadius: BorderRadius.circular(100.r),
                width: 109.w,
                height: 58.h,
                onPressed: () {
                  context.go(RouteName.weatherScreen);                },
                text: "Skip",
              ),
            ],
          ),
          SizedBox(height: 30.h),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: List.generate(
              3,
              (index) => Consumer(
                builder: (_, ref, _) {
                  return Container(
                    margin: EdgeInsets.only(right: 10),
                    width: 25.w,
                    height: 7.h,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(100.r),
                      color:
                          index ==
                              ref
                                  .watch(onboardingProvider)
                                  .currentOnboardingIndex
                          ? Colors.white
                          : AppColors.surface,
                    ),
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
