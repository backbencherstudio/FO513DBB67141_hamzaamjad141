import 'package:aviation_app/core/constant/icons.dart';
import 'package:aviation_app/core/constant/padding.dart';
import 'package:aviation_app/core/theme/theme_extension/app_colors.dart';
import 'package:aviation_app/core/utils/common_widget/common_widget.dart';
import 'package:aviation_app/features/create_screen/create_screen.dart';
import 'package:aviation_app/features/voice_ai_screen/presentation/widget/audio_message_wave_from.dart';
import 'package:aviation_app/features/voice_ai_screen/presentation/widget/circle_shadow_box.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

class VoiceAiScreen extends StatelessWidget {
  const VoiceAiScreen({super.key});

  @override
  Widget build(BuildContext context) {
    TextTheme textTheme = Theme.of(context).textTheme;
    return CreateScreen(
      child: SafeArea(
        child: Padding(
          padding: AppPadding.screenHorizontal,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 20.w),
              Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Center(
                    child: Text(
                      'Ask me anything about aviation!',
                      style: textTheme.headlineMedium!.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 20.h),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  CommonWidget.secondaryButton(
                    child: SvgPicture.asset(AppIcons.keyboardStroke),
                  ),
                  CircleShadowBox(
                    replacement: SvgPicture.asset(
                      'assets/images/Timer.svg',
                      width: 200.h,
                      height: 200.h,
                    ),
                    child: Text('00 : 00'),
                  ),
                  CommonWidget.secondaryButton(
                    child: SvgPicture.asset(AppIcons.cancelIcon),
                  ),
                ],
              ),
              SizedBox(height: 20),
              Center(
                child: Text(
                  'Hold to Speak',
                  style: textTheme.bodyMedium!.copyWith(
                    color: AppColors.secondaryTextColor,
                  ),
                ),
              ),
              SizedBox(height: 20),
              AudioMessageWidget(),
              SizedBox(height: 20),
              AudioMessageWidget(),
            ],
          ),
        ),
      ),
    );
  }
}
