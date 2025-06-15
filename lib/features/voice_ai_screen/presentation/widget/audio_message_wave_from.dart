import 'dart:math';

import 'package:aviation_app/core/utils/common_widget/common_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AudioMessageWidget extends StatelessWidget {
  const AudioMessageWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 398.w,
      height: 86.h,
      padding: EdgeInsets.symmetric(horizontal: 12.w),
      decoration: BoxDecoration(
        color: const Color(0xFF1D1F2C),
        borderRadius: BorderRadius.circular(20.r),
        border: Border.all(color: Colors.white.withValues(alpha: 0.15)),
      ),
      child: Row(
        spacing: 12.w,
        children: [
          CircleAvatar(
            radius: 26.r,
            backgroundImage: NetworkImage(
              'https://i.pravatar.cc/150?img=19', // Replace with your image
            ),
          ),
          Expanded(child: Waveform()),
          CommonWidget.secondaryButton(
            child: Icon(Icons.play_arrow, color: Colors.white, size: 24),
          ),
        ],
      ),
    );
  }
}

// Dummy waveform painter (you can replace this later)
class Waveform extends StatelessWidget {
  const Waveform({super.key});

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
      canvas.drawLine(
        Offset(x, centerY - y),
        Offset(x, centerY + y),
        paint,
      );
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

