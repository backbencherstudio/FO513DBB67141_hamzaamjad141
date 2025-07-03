import 'package:aviation_app/core/constant/icons.dart';
import 'package:aviation_app/core/constant/padding.dart';
import 'package:aviation_app/core/theme/theme_extension/app_colors.dart';
import 'package:aviation_app/core/utils/common_widget/common_widget.dart';
import 'package:aviation_app/features/create_screen/create_screen.dart';
import 'package:aviation_app/features/voice_ai_screen/presentation/widget/audio_message_wave_from.dart';
import 'package:aviation_app/features/voice_ai_screen/presentation/widget/build_text_filed.dart';
import 'package:aviation_app/features/voice_ai_screen/presentation/widget/circle_shadow_box.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'widget/ai_voice_recording_widget.dart';
import '../data/provider/text_filed_to_voice.dart';

class VoiceAiScreen extends ConsumerWidget {
  const VoiceAiScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    TextTheme textTheme = Theme.of(context).textTheme;
    final showTextField = ref.watch(showTextFieldProvider);

    return CreateScreen(
      child: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: AppPadding.screenHorizontal,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                SizedBox(height: 20.w),
                GestureDetector(
                  onTap: () {
                    ref.read(showTextFieldProvider.notifier).state =
                    !showTextField; // Toggle state
                  },
                  child: CommonWidget.secondaryButton(
                    child: SvgPicture.asset(AppIcons.keyboardStroke),
                  ),
                ),
                SizedBox(height: 30),
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
                AnimatedSwitcher(
                  duration: const Duration(milliseconds: 300),
                  transitionBuilder: (Widget child, Animation<double> animation) {
                    return ScaleTransition(
                      scale: Tween<double>(begin: 0.9, end: 1.0).animate(
                        CurvedAnimation(
                          parent: animation,
                          curve: Curves.easeInOut,
                        ),
                      ),
                      child: FadeTransition(
                        opacity: Tween<double>(begin: 0.0, end: 1.0).animate(
                          CurvedAnimation(
                            parent: animation,
                            curve: Curves.easeInOut,
                          ),
                        ),
                        child: child,
                      ),
                    );
                  },
                  child: showTextField
                      ? const BuildTextFiled(key: ValueKey('textField'))
                      : Row(
                    key: const ValueKey('circleBoxRow'),
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      CircleShadowBox(
                        replacement: AiVoiceRecordingWidgets(),
                        child: const Text('00 : 00'),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 20),
                Center(
                  child: Text(
                    showTextField ? 'Type your question' : 'Hold to Speak',
                    style: textTheme.bodyMedium!.copyWith(
                      color: AppColors.secondaryTextColor,
                    ),
                  ),
                ),
                SizedBox(height: 20),
                const AudioMessageWidget(),
                SizedBox(height: 20),
                const AudioMessageWidget(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}