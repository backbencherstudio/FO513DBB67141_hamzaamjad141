import 'package:aviation_app/core/constant/padding.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class OnboardingUserGuide extends StatelessWidget{
  const OnboardingUserGuide({super.key, this.imagePath, required this.headerText, required this.bodyText });

  final String? imagePath;
  final String headerText;
  final String bodyText;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Padding(
      padding: AppPadding.screenHorizontal,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if(imagePath!=null)
            Align(
              alignment: Alignment.center,
              child: Column(
                children: [
                  Image.asset(imagePath!,
                  width: 169.w,
                    height: 169.h,
                    fit: BoxFit.contain,
                  ),
                  SizedBox(height: 40.h,)
                ],
              ),
            ),

          Text(headerText,style: textTheme.headlineMedium ),
          SizedBox(height: 24.h,),
          Text(bodyText,style: textTheme.bodyMedium?.copyWith(color: Color(0xff919EAB)), ),
        ],
      ),
    );
  }
}