import 'dart:async';
import 'dart:math' as math;
import 'package:aviation_app/core/theme/theme_extension/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../data/riverpod/audio_provider/audio_provider.dart';

List<double> heightStore = [];
List<bool> increaseStatus = [];
void generate() {
  final surfaceHeight = 300.w / 2;
  final math.Random random = math.Random();
  for (int i = 0; i < 100; i++) {
    final height = (random.nextInt(140)); // Random height up to 80% of surface
    heightStore = [...heightStore, height.toDouble()];
    if (height <= surfaceHeight * 0.5) {
      increaseStatus = [...increaseStatus, true];
    } else {
      increaseStatus = [...increaseStatus, false];
    }
  }
}

class AutoUpdatingWaveform extends ConsumerStatefulWidget {
  final String audioUrl;
  const AutoUpdatingWaveform({super.key, required this.audioUrl});

  @override
  ConsumerState<AutoUpdatingWaveform> createState() =>
      _AutoUpdatingWaveformState();
}

class _AutoUpdatingWaveformState extends ConsumerState<AutoUpdatingWaveform> {
  late Timer _timer;

  @override
  void initState() {
    super.initState();
    generate();
    _timer = Timer.periodic(const Duration(milliseconds: 1000), (_) {
      setState(() {});
    });
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(audioPlayerProvider(widget.audioUrl));
    return CustomPaint(
      size: Size(double.infinity, 300.h),
      painter: WaveformPainter(state.currentPosition, state.totalDuration),
    );
  }
}

class WaveformPainter extends CustomPainter {
  final Duration currentPosition;
  final Duration totalDuration;
  final math.Random random = math.Random();

  WaveformPainter(this.currentPosition, this.totalDuration);

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()..style = PaintingStyle.fill;

    const barCount = 100;
    const barWidth = 2.50;
    const spacing = 1.0;
    final totalWidth = (barWidth + spacing) * barCount - spacing;
    final startX = (size.width - totalWidth) / 2;

    final surfaceHeight = size.height / 2;
    final dividerY = surfaceHeight;

    final progressRatio =
        currentPosition.inMilliseconds /
        totalDuration.inMilliseconds.clamp(1, double.infinity);

    for (int i = 0; i < barCount; i++) {
      final x = startX + i * (barWidth + spacing);
      double height = heightStore[i];

      if (increaseStatus[i]) {
        height += random.nextInt(3).toDouble();
        if (height >= surfaceHeight) {
          height = surfaceHeight;
          increaseStatus[i] = false;
        }
      } else {
        height -= random.nextInt(3).toDouble();
        if (height <= surfaceHeight * 0.3) {
          height = surfaceHeight * 0.3;
          increaseStatus[i] = true;
        }
      }

      height = height.clamp(0, surfaceHeight);
      heightStore[i] = height;

      final normalizedX = i / (barCount - 1);
      paint.color = normalizedX <= progressRatio
          ? AppColors.primary
          : Colors.grey;
      canvas.drawRect(
        Rect.fromLTWH(x, dividerY - height, barWidth, height),
        paint,
      );
    }

    final dividerPaint = Paint()
      ..color = Colors.white.withOpacity(0.2)
      ..strokeWidth = 1.0;
    canvas.drawLine(
      Offset(0, dividerY),
      Offset(size.width, dividerY),
      dividerPaint,
    );

    for (int i = 0; i < barCount; i++) {
      final x = startX + i * (barWidth + spacing);
      final height = heightStore[i] * 0.6;
      final normalizedX = i / (barCount - 1);
      paint.color =
          (normalizedX <= progressRatio ? AppColors.primary : Colors.grey)
              .withValues(alpha: 0.4);
      canvas.drawRect(Rect.fromLTWH(x, dividerY + 2, barWidth, height), paint);
    }
  }

  @override
  bool shouldRepaint(covariant WaveformPainter oldDelegate) =>
      currentPosition != oldDelegate.currentPosition ||
      totalDuration != oldDelegate.totalDuration;
}
