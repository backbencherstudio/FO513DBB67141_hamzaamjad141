import 'package:aviation_app/core/constant/icons.dart';
import 'package:aviation_app/core/constant/padding.dart';
import 'package:aviation_app/core/theme/theme_extension/app_colors.dart';
import 'package:aviation_app/features/create_screen/create_screen.dart';
import 'package:aviation_app/features/voice_ai_screen/presentation/widget/build_text_filed.dart';
import 'package:aviation_app/features/voice_ai_screen/presentation/widget/chat_history_widget/chat_history.dart';
import 'package:aviation_app/features/voice_ai_screen/presentation/widget/circle_shadow_box.dart';
import 'package:aviation_app/features/voice_ai_screen/presentation/widget/text_field_toggle.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import '../data/provider/chat_bot_provider/chat_bot_provider.dart';
import 'widget/ai_voice_recording_widget.dart';
import '../data/provider/text_filed_to_voice.dart';

class VoiceAiScreen extends ConsumerStatefulWidget {
  const VoiceAiScreen({super.key});

  @override
  ConsumerState<VoiceAiScreen> createState() => _VoiceAiScreenState();
}

class _VoiceAiScreenState extends ConsumerState<VoiceAiScreen> {
  final TextEditingController messageController = TextEditingController();

  @override
  void dispose() {
    messageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    TextTheme textTheme = Theme.of(context).textTheme;
    final showTextField = ref.watch(showTextFieldProvider);
    final voiceAiState = ref.watch(voiceAiProvider); // Watch the provider state

    return CreateScreen(
      child: SafeArea(
        child: Column(
          children: [
            // Header and input section
            Padding(
              padding: AppPadding.screenHorizontal,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  SizedBox(height: 20.w),
                  TextFieldToggle(keyBoard: AppIcons.keyboardStroke,mic: AppIcons.mic),
                  Center(
                    child: Consumer(
                      builder: (context, ref,child) {
                        return voiceAiState.messages.isEmpty?Column(
                          children: [
                            SizedBox(height: 30),
                            Text(
                              'Ask me anything about aviation!',
                              style: textTheme.headlineMedium!.copyWith(
                                fontWeight: FontWeight.bold,
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ],
                        ):SizedBox();
                      }
                    ),
                  ),
                  SizedBox(height: 20.h),
                  AnimatedSwitcher(
                    duration: const Duration(milliseconds: 300),
                    transitionBuilder:
                        (Widget child, Animation<double> animation) {
                          return ScaleTransition(
                            scale: Tween<double>(begin: 0.9, end: 1.0).animate(
                              CurvedAnimation(
                                parent: animation,
                                curve: Curves.easeInOut,
                              ),
                            ),
                            child: FadeTransition(
                              opacity: Tween<double>(begin: 0.0, end: 1.0)
                                  .animate(
                                    CurvedAnimation(
                                      parent: animation,
                                      curve: Curves.easeInOut,
                                    ),
                                  ),
                              child: child,
                            ),
                          );
                        },
                    child: !showTextField
                        ? BuildTextFiled(
                            key: const ValueKey('textField'),
                            messageController: messageController,
                          )
                        : Row(
                            key: const ValueKey('circleBoxRow'),
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              CircleShadowBox(
                                replacement: const AiVoiceRecordingWidgets(),
                                child: const Text('00 : 00'),
                              ),
                            ],
                          ),
                  ),
                  SizedBox(height: 20),
                  Center(
                    child: Text(
                      !showTextField ? 'Type your question' : 'Hold to Speak',
                      style: textTheme.bodyMedium!.copyWith(
                        color: AppColors.secondaryTextColor,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            // Chat history
            ChatHistory(voiceAiState: voiceAiState, textTheme: textTheme),
          ],
        ),
      ),
    );
  }
}
