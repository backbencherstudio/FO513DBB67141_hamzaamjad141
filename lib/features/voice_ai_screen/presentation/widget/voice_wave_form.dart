import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class VoiceWaveform extends StatelessWidget {
  final double progress;

  const VoiceWaveform({super.key, required this.progress});

  @override
  Widget build(BuildContext context) {
    debugPrint('VoiceWaveform build with progress: $progress');
    return CustomPaint(
      size: Size(double.infinity, 40.h),
      painter: _WaveformPainter(progress),
    );
  }
}

class _WaveformPainter extends CustomPainter {
  final double progress;
  final List<double> bars;

  _WaveformPainter(this.progress)
    : bars = List.generate(40, (_) => Random().nextDouble() * 10 + 2);

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.white
      ..strokeCap = StrokeCap.round
      ..strokeWidth = 2;

    final spacing = size.width / bars.length;
    final centerY = size.height / 2;
    final visibleBars = (bars.length * progress).ceil();

    debugPrint(
      'Painting waveform with progress: $progress, visibleBars: $visibleBars',
    );
    for (int i = 0; i < bars.length; i++) {
      final x = i * spacing;
      final y = bars[i] * (i < visibleBars ? 1.0 : 0.3);
      final alpha = i < visibleBars
          ? 1.0
          : 0.2; // Fully white for played, dim for unplayed
      canvas.drawLine(
        Offset(x, centerY - y),
        Offset(x, centerY + y),
        paint..color = Colors.white.withOpacity(alpha),
      );
    }
  }

  @override
  bool shouldRepaint(covariant _WaveformPainter oldDelegate) =>
      oldDelegate.progress != progress;
}
