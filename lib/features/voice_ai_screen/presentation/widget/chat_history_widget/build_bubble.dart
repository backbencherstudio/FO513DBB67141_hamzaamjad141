import 'package:aviation_app/features/voice_ai_screen/presentation/widget/chat_history_widget/text_modifying.dart';
import 'package:flutter/animation.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';

import '../../../../../core/theme/theme_extension/app_colors.dart';
import '../../../data/entity/chat_message_state.dart';

Widget buildChatBubble(
    BuildContext context,
    ChatMessage message,
    int index,
    ) {
  final isUser = message.isUser;
  final alignment = isUser ? Alignment.centerRight : Alignment.centerLeft;
  final textTheme = Theme.of(context).textTheme;
  final bubbleColor = isUser
      ? LinearGradient(
    colors: [
      AppColors.primary.withOpacity(0.4),
      AppColors.primary.withOpacity(0.2),
    ],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  )
      : LinearGradient(
    colors: [
      AppColors.secondary.withOpacity(0.2),
      AppColors.secondary.withOpacity(0.1),
    ],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );
  final borderRadius = isUser
      ? BorderRadius.only(
    topLeft: Radius.circular(16.r),
    bottomLeft: Radius.circular(16.r),
    bottomRight: Radius.circular(4.r),
    topRight: Radius.circular(16.r),
  )
      : BorderRadius.only(
    topLeft: Radius.circular(16.r),
    bottomLeft: Radius.circular(4.r),
    bottomRight: Radius.circular(16.r),
    topRight: Radius.circular(16.r),
  );

  final timestamp = DateFormat('HH:mm').format(message.timestamp);

  return Align(
    alignment: alignment,
    child: Container(
      margin: EdgeInsets.symmetric(vertical: 6.h, horizontal: 8.w),
      constraints: BoxConstraints(maxWidth: 300.w),
      child: Column(
        crossAxisAlignment:
        isUser ? CrossAxisAlignment.end : CrossAxisAlignment.start,
        children: [
          Container(
            padding: EdgeInsets.all(12.w),
            decoration: BoxDecoration(
              gradient: bubbleColor,
              borderRadius: borderRadius,
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.1),
                  blurRadius: 6,
                  offset: const Offset(0, 3),
                ),
              ],
            ),
            child: Column(
              crossAxisAlignment:
              isUser ? CrossAxisAlignment.end : CrossAxisAlignment.start,
              children: [
                buildResponseText(message.text),
                SizedBox(height: 4.h),
                Text(
                  timestamp,
                  style: textTheme.bodySmall!.copyWith(
                    color: Colors.white70,
                    fontSize: 10.sp,
                  ),
                ),
              ],
            ),
          ).animate().fadeIn(duration: 400.ms, curve: Curves.easeInOut).slideX(
            begin: isUser ? 0.2 : -0.2,
            end: 0,
            duration: 400.ms,
            curve: Curves.easeInOut,
          ),
        ],
      ),
    ),
  );
}


