import 'package:aviation_app/core/constant/logos.dart';
import 'package:aviation_app/core/constant/padding.dart';
import 'package:aviation_app/features/create_screen/create_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

class OnboardingScreen extends StatelessWidget{
  const OnboardingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return CreateScreen(
        child:  Padding(
          padding: AppPadding.screenHorizontal,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Align(
                  alignment: Alignment.center,
                  child: SvgPicture.asset(AppLogo.splashLogo)),
              SizedBox(height: 140.h,),
              Text("Fly smarter.\nLearn faster",style: textTheme.headlineMedium,),
              SizedBox(height: 24.h,),
              Text("Access real-time aviation tools, AI-powered guidance, "
                  "and expert resources — designed to help you master "
                  "the skies with confidence.",style: textTheme.bodyMedium?.copyWith(color: Color(0xff919EAB)),),
            ],
          ),
        )
    );
  }
}