import 'dart:math' as math;
import 'package:aviation_app/core/theme/theme_extension/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../data/provider/voice_recorder_provider.dart';

class AiVoiceRecordingWidgets extends ConsumerStatefulWidget {
  const AiVoiceRecordingWidgets({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _AiVoiceRecordingWidgetsState();

}

class _AiVoiceRecordingWidgetsState extends ConsumerState<AiVoiceRecordingWidgets>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _rotationAnimation;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    );

    _rotationAnimation = Tween<double>(begin: 0, end: 2 * math.pi)
        .animate(CurvedAnimation(parent: _controller, curve: Curves.linear));

    ref.read(recorderProvider.notifier).startRecording();
  }

  @override
  Widget build(BuildContext context) {
    final recorderState = ref.watch(recorderProvider);

    if (recorderState.isRecording) {
      _controller.repeat();
    } else {
      _controller.stop();
    }

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Stack(
          alignment: Alignment.center,
          children: [
            AnimatedBuilder(
              animation: _rotationAnimation,
              builder: (context, child) {
                return Transform.rotate(
                  angle: _rotationAnimation.value * 1,
                  child: SvgPicture.asset(
                    'assets/images/voice_assistant/Ellipse 135 (1).svg',
                    width: 200.0,
                    height: 200.0,
                    fit: BoxFit.contain,
                  ),
                );
              },
            ),
            // Second rotating element (anticlockwise rotation, full 360 degrees)
            AnimatedBuilder(
              animation: _rotationAnimation,
              builder: (context, child) {
                return Transform.rotate(
                  angle: -_rotationAnimation.value * 1,
                  child: SvgPicture.asset(
                    'assets/images/voice_assistant/Ellipse 136.svg',
                    width: 195.0,
                    height: 195.0,
                    fit: BoxFit.contain,
                  ),
                );
              },
            ),
            // Third rotating element (slow rotation, full 360 degrees)
            AnimatedBuilder(
              animation: _rotationAnimation,
              builder: (context, child) {
                return Transform.rotate(
                  angle: _rotationAnimation.value * 0.5,
                  child: SvgPicture.asset(
                    'assets/images/voice_assistant/Ellipse 137.svg',
                    width: 200.0,
                    height: 200.0,
                    fit: BoxFit.contain,
                  ),
                );
              },
            ),

            ClipRRect(
              borderRadius: BorderRadiusGeometry.circular(100),
              child: Container(
                height: 160,
                width: 160,
                color: AppColors.secondary,
                child: Center(
                  child: Text(
                      "${(ref.read(recorderProvider).recordedTime?.inMinutes ?? 0).toString().padLeft(2, '0')} : "
                          "${(ref.read(recorderProvider).recordedTime?.inSeconds ?? 0 % 60).toString().padLeft(2, '0')}"
                  ),
                ),
              ),
            )
          ],
        ),
        SizedBox(height: 20),
      ],
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}
