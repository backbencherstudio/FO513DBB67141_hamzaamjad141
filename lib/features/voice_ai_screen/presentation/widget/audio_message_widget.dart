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

class AudioMessageWidget extends ConsumerStatefulWidget {
  final ChatMessage message;
  const AudioMessageWidget({super.key, required this.message});

  @override
  ConsumerState<AudioMessageWidget> createState() => _AudioMessageWidgetState();
}

class _AudioMessageWidgetState extends ConsumerState<AudioMessageWidget> {
  bool hasPlayed = false;

  @override
  void initState() {
    super.initState();

    // Wait until first frame is rendered before accessing context-dependent providers
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      if (!hasPlayed && !widget.message.isUser) {
        try {
          final ttsService = ref.read(textToSpeechServiceProvider);
          await ttsService.speakText(widget.message.text, widget.message.id);
          hasPlayed = true;
        } catch (e) {
          debugPrint('Auto-play failed for id: ${widget.message.id}: $e');
          if (mounted) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text('Failed to play TTS: $e')),
            );
          }
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final user = ref.watch(authProvider).user;
    final playbackState =
        ref.watch(playbackStateProvider)[widget.message.id] ??
            PlaybackState(isSpeaking: false, progress: 0.0);
    final isSpeaking = playbackState.isSpeaking;
    final progress = playbackState.progress;

    return Align(
      alignment:
      widget.message.isUser ? Alignment.centerRight : Alignment.centerLeft,
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
            widget.message.isUser
                ? CircleAvatar(
              backgroundColor: AppColors.primary,
              radius: 26.r,
              backgroundImage: user?.image != null
                  ? NetworkImage(user?.image ?? "")
                  : null,
              child: user?.image == null
                  ? Icon(Icons.person, size: 26.r, color: AppColors.onPrimary)
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
                  await ttsService.speakText(widget.message.text, widget.message.id);
                } catch (e) {
                  debugPrint('Manual play error: $e');
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
            widget.message.isUser
                ? GestureDetector(
              onTap: () async {
                final ttsService = ref.read(textToSpeechServiceProvider);
                if (isSpeaking) {
                  ttsService.stop();
                  return;
                }
                try {
                  await ttsService.speakText(widget.message.text, widget.message.id);
                } catch (e) {
                  debugPrint('Manual play error: $e');
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
