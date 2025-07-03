import 'package:aviation_app/core/constant/logos.dart';
import 'package:aviation_app/core/constant/padding.dart';
import 'package:aviation_app/core/theme/theme_extension/app_colors.dart';
import 'package:aviation_app/core/utils/utils.dart';
import 'package:aviation_app/features/create_screen/create_screen.dart';
import 'package:aviation_app/features/onboarding/presentation/widget/onboarding_body.dart';
import 'package:aviation_app/features/onboarding/presentation/widget/onboarding_footer.dart';
import 'package:aviation_app/features/onboarding/presentation/widget/onboarding_user_guide.dart';
import 'package:aviation_app/features/onboarding/riverpod/onboarding_notifier.dart';
import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:slider_button/slider_button.dart';

class OnboardingScreen extends ConsumerStatefulWidget {
  const OnboardingScreen({super.key});

  @override
  ConsumerState<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends ConsumerState<OnboardingScreen>
    with SingleTickerProviderStateMixin {
  late final TabController tabBarController;

  @override
  initState() {
    tabBarController = TabController(length: 3, vsync: this);
    super.initState();
  }

  @override
  void dispose() {
    tabBarController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return CreateScreen(
      child: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Spacer(),
            Container(
              constraints: BoxConstraints(minHeight: 215.h, maxHeight: 545.h),
              child: OnboardingBody(tabBarController: tabBarController),
            ),
            SizedBox(height: 48.h),
            OnboardingFooter(tabBarController: tabBarController,),

            Spacer(),
          ],
        ),
      ),
    );
  }
}
