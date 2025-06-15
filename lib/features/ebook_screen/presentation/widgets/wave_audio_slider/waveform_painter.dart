import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

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

    // Define surface height (50% of total height for wave + reflection)
    final surfaceHeight = size.height / 2;
    final dividerY = surfaceHeight; // Divider at the middle
    // Calculate progress ratio
    final progressRatio =
        currentPosition.inSeconds /
            totalDuration.inSeconds.clamp(1, double.infinity);

    // Draw the waveform bars on the surface with random heights
    for (int i = 0; i < barCount; i++) {
      final x = startX + i * (barWidth + spacing);
      double height = 0;
      if (heightStore.length <= i) {
        height = random.nextDouble() * surfaceHeight; // Initialize if not set
        heightStore = [...heightStore, height];
        increaseStatus = [...increaseStatus, height <= surfaceHeight * 0.8];
      } else {
        // Update height based on increaseStatus
        if (increaseStatus[i]) {
          height = heightStore[i] + random.nextInt(7);
          height = height.clamp(
            0,
            surfaceHeight,
          ); // Bound between 0 and surfaceHeight
          if (height >= surfaceHeight) {
            increaseStatus[i] = false; // Switch to decrease when max is reached
          }
        } else {
          height = heightStore[i] - random.nextInt(7);
          height = height.clamp(
            0,
            surfaceHeight,
          ); // Bound between 0 and surfaceHeight
          if (height <= surfaceHeight * 0.3) {
            increaseStatus[i] = true; // Switch to increase when below 50%
          }
        }
        heightStore[i] = height; // Update heightStore with bounded value
      }
      final normalizedX = i / (barCount - 1); // 0 to 1 for progress
      paint.color = normalizedX <= progressRatio ? Colors.blue : Colors.grey;
      canvas.drawRect(
        Rect.fromLTWH(x, dividerY - height, barWidth, height),
        paint,
      );
    }

    // Draw the divider between wave and reflection
    final dividerPaint = Paint()
      ..color = Colors.white
          .withValues(alpha: 0.2) // Light divider
      ..strokeWidth = 1.0;
    canvas.drawLine(
      Offset(0, dividerY),
      Offset(size.width, dividerY),
      dividerPaint,
    );

    // Draw the reflection with 40% opacity and same height
    for (int i = 0; i < barCount; i++) {
      final x = startX + i * (barWidth + spacing);
      final height = heightStore[i] * 0.6;
      final reflectionHeight = height;
      final normalizedX = i / (barCount - 1);
      paint.color = (normalizedX <= progressRatio ? Colors.blue : Colors.grey)
          .withValues(alpha: 0.4); // 40% opacity
      canvas.drawRect(
        Rect.fromLTWH(x, dividerY + 2, barWidth, reflectionHeight),
        paint,
      ); // Offset by 2 for separation
    }
  }

  @override
  bool shouldRepaint(covariant WaveformPainter oldDelegate) =>
      currentPosition != oldDelegate.currentPosition ||
          totalDuration != oldDelegate.totalDuration;
}
