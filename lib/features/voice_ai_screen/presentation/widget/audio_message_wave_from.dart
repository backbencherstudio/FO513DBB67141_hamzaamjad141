import 'package:aviation_app/core/constant/logos.dart';
import 'package:aviation_app/core/theme/theme_extension/app_colors.dart';
import 'package:aviation_app/core/utils/common_widget/common_widget.dart';
import 'package:aviation_app/features/voice_ai_screen/data/entity/chat_message_state.dart';
import 'package:aviation_app/features/voice_ai_screen/data/provider/playback_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../auth_screens/auth_provider/auth_provider.dart';
import '../../data/provider/text_to_speech_service.dart';
import 'voice_wave_form.dart';

class AudioMessageWidget extends ConsumerWidget {
  final ChatMessage message;
  const AudioMessageWidget({super.key, required this.message});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final user = ref.watch(authProvider).user;
    final playbackState =
        ref.watch(playbackStateProvider)[message.id] ??
        PlaybackState(isSpeaking: false, progress: 0.0);
    final isSpeaking = playbackState.isSpeaking;
    final progress = playbackState.progress;

    // Debug state changes
    ref.listen(playbackStateProvider, (previous, next) {
      final prevState = previous?[message.id]?.isSpeaking ?? false;
      final nextState = next[message.id]?.isSpeaking ?? false;
      final prevProgress =
          previous?[previous[message.id] != null ? message.id : '']?.progress ??
          0.0;
      final nextProgress = next[message.id]?.progress ?? 0.0;
      if (prevState != nextState || prevProgress != nextProgress) {
        debugPrint(
          'State for id: ${message.id}, isSpeaking: $prevState -> $nextState, progress: $prevProgress -> $nextProgress',
        );
      }
    });

    // Debug widget rebuild
    debugPrint(
      'Building AudioMessageWidget for id: ${message.id}, text: "${message.text}", isSpeaking: $isSpeaking, progress: $progress',
    );

    return Align(
      alignment: message.isUser ? Alignment.centerRight : Alignment.centerLeft,
      child: Container(
        width: 300.w,
        height: 86.h,
        margin: EdgeInsets.only(bottom: 10.h),
        padding: EdgeInsets.symmetric(horizontal: 12.w),
        decoration: BoxDecoration(
          color: const Color(0xFF1D1F2C),
          borderRadius: BorderRadius.circular(20.r),
          border: Border.all(color: Colors.white.withOpacity(0.15)),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            message.isUser
                ? CircleAvatar(
                    backgroundColor: AppColors.primary,
                    radius: 26.r,
                    backgroundImage: user?.image != null
                        ? NetworkImage(user?.image ?? "")
                        : null,
                    child: user?.image == null
                        ? Icon(
                            Icons.person,
                            size: 26.r,
                            color: AppColors.onPrimary,
                          )
                        : null,
                  )
                : GestureDetector(
                    onTap: () async {
                      final ttsService = ref.read(textToSpeechServiceProvider);
                      if (isSpeaking) {
                        ttsService.stop();
                        return;
                      }

                      try {
                        await ttsService.speakText(message.text, message.id);
                      } catch (e) {
                        debugPrint('Error for id: ${message.id}: $e');
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text('Failed to play TTS: $e')),
                        );
                      }
                    },
                    child: CommonWidget.secondaryButton(
                      child: Icon(
                        isSpeaking ? Icons.stop : Icons.play_arrow,
                        color: Colors.white,
                        size: 24,
                      ),
                    ),
                  ),
            SizedBox(width: 5.w),
            Expanded(child: VoiceWaveform(progress: progress)),
            SizedBox(width: 5.w),
            message.isUser
                ? GestureDetector(
                    onTap: () async {
                      final ttsService = ref.read(textToSpeechServiceProvider);
                      if (isSpeaking) {
                        ttsService.stop();
                        return;
                      }

                      try {
                        await ttsService.speakText(message.text, message.id);
                      } catch (e) {
                        debugPrint('Error for id: ${message.id}: $e');
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text('Failed to play TTS: $e')),
                        );
                      }
                    },

                    child: CommonWidget.secondaryButton(
                      child: Icon(
                        isSpeaking ? Icons.stop : Icons.play_arrow,
                        color: Colors.white,
                        size: 24,
                      ),
                    ),
                  )
                : CircleAvatar(
                    radius: 26.r,
                    backgroundImage: const AssetImage('assets/app_icon.png'),
                  ),
          ],
        ),
      ),
    );
  }
}
