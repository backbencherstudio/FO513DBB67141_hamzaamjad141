import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'waveform_painter.dart'; // Import the painter

class WaveformSlider extends StatelessWidget {
  final Duration currentPosition;
  final Duration totalDuration;
  final ValueChanged<Duration> onChanged;
  final bool isEnabled;

  const WaveformSlider({
    super.key,
    required this.currentPosition,
    required this.totalDuration,
    required this.onChanged,
    this.isEnabled = true,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onHorizontalDragUpdate: isEnabled
          ? (details) {
        final renderBox = context.findRenderObject() as RenderBox?;
        if (renderBox != null) {
          final localPosition = details.localPosition.dx;
          final width = renderBox.size.width;
          final value = (localPosition / width).clamp(0.0, 1.0);
          final newPosition = totalDuration * value;
          onChanged(newPosition);
        }
      }
          : null,
      onTapDown: isEnabled
          ? (details) {
        final renderBox = context.findRenderObject() as RenderBox?;
        if (renderBox != null) {
          final localPosition = details.localPosition.dx;
          final width = renderBox.size.width;
          final value = (localPosition / width).clamp(0.0, 1.0);
          final newPosition = totalDuration * value;
          onChanged(newPosition);
        }
      }
          : null,
      child: SizedBox(
        width: 300.w,
        height: 56.h, // Total height including wave, divider, and reflection
        child: CustomPaint(
          painter: WaveformPainter(currentPosition, totalDuration),
        ),
      ),
    );
  }
}
