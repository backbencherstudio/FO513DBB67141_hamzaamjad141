import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class VoiceWaveform extends StatelessWidget {
  const VoiceWaveform({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      size: Size(double.infinity, 40.h),
      painter: _WaveformPainter(),
    );
  }
}

class _WaveformPainter extends CustomPainter {
  final List<double> bars;

  _WaveformPainter()
    : bars = List.generate(40, (_) => Random().nextDouble() * 10 + 2);

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.white.withValues(alpha: 0.2)
      ..strokeCap = StrokeCap.round
      ..strokeWidth = 2;

    final spacing = size.width / bars.length;
    final centerY = size.height / 2;

    for (int i = 0; i < bars.length; i++) {
      final x = i * spacing;
      final y = bars[i];
      canvas.drawLine(Offset(x, centerY - y), Offset(x, centerY + y), paint);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
