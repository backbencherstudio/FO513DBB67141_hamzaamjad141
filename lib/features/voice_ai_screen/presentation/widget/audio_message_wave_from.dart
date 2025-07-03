import 'package:aviation_app/core/utils/common_widget/common_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'voice_wave_form.dart';

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
          Expanded(child: VoiceWaveform()),
          CommonWidget.secondaryButton(
            child: Icon(Icons.play_arrow, color: Colors.white, size: 24),
          ),
        ],
      ),
    );
  }
}



