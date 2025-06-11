import 'package:aviation_app/core/constant/icons.dart';
import 'package:aviation_app/features/onboarding/riverpod/onboarding_notifier.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

import '../../../../core/constant/logos.dart';
import 'onboarding_user_guide.dart';

class OnboardingBody extends StatelessWidget{
  const OnboardingBody({super.key, required this.tabBarController});

  final TabController tabBarController;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Align(
          alignment: Alignment.center,
          child: SvgPicture.asset(AppLogo.splashLogo,width: 295.w,height: 77.h,),
        ),
        Consumer(
          builder: (_, ref, _) {
            final onboardingState = ref.watch(onboardingProvider);
            return SizedBox(height: onboardingState.currentOnboardingIndex == 2 ? 32.h : 125.h,);
          }
        ),
        Expanded(
          child: TabBarView(
              controller: tabBarController,
              physics: NeverScrollableScrollPhysics(
              ),
              children: [
                OnboardingUserGuide(
                  headerText: "Fly smarter.\nLearn faster",
                  bodyText: "Access real-time aviation tools, AI-powered guidance, "
                      "and expert resources — designed to help you master "
                      "the skies with confidence.",
                ),
                OnboardingUserGuide(
                  headerText: "Your Co-Pilot in\nAviation Education",
                  bodyText: "From weather updates to flight logs, podcasts to e-books — everything you need to elevate your skills, all in one app.",
                ),
                OnboardingUserGuide(
                  imagePath: AppIcons.voiceAi,
                  headerText: "Meet PilotGPT Your Personal Aviation Copilot",
                  bodyText: "Ask questions, get instant guidance, and explore aviation knowledge hands-free.",
                ),
              ]
          ),
        ),

      ],
    );
  }
}