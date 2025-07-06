import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';

import '../../../../core/constant/padding.dart';
import '../../../../core/theme/theme_extension/app_colors.dart';
import '../../data/chat_bot_provider/chat_bot_provider.dart';

class ChatHistory extends StatelessWidget {
  const ChatHistory({
    super.key,
    required this.voiceAiState,
    required this.textTheme,
  });

  final VoiceAiState voiceAiState;
  final TextTheme textTheme;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        decoration: BoxDecoration(
          color: AppColors.secondary.withOpacity(0.05),
          borderRadius: BorderRadius.vertical(top: Radius.circular(20.r)),
        ),
        child: SingleChildScrollView(
          reverse: true,
          child: Padding(
            padding: AppPadding.screenHorizontal,
            child: Column(
              children: [
                SizedBox(height: 10.h),
                voiceAiState.messages.isNotEmpty
                    ? ListView.builder(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  itemCount: voiceAiState.messages.length,
                  itemBuilder: (context, index) {
                    final message = voiceAiState.messages[index];
                    return _buildChatBubble(context, message, index);
                  },
                )
                    : Padding(
                  padding: EdgeInsets.symmetric(vertical: 20.h),
                  child: Center(
                    child: Text(
                      'Start the conversation!',
                      style: textTheme.bodyMedium!.copyWith(
                        color: AppColors.secondaryTextColor,
                        fontStyle: FontStyle.italic,
                      ),
                    ),
                  ),
                ),
                if (voiceAiState.isLoading)
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: 10.h),
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: _buildTypingIndicator(),
                    ),
                  ),
                if (voiceAiState.error.isNotEmpty)
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: 10.h),
                    child: Center(
                      child: Text(
                        voiceAiState.error,
                        style: textTheme.bodyMedium!.copyWith(
                          color: Colors.redAccent,
                          fontWeight: FontWeight.w500,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                SizedBox(height: 80.h),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildChatBubble(
      BuildContext context,
      ChatMessage message,
      int index,
      ) {
    final isUser = message.isUser;
    final alignment = isUser ? Alignment.centerRight : Alignment.centerLeft;
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
          crossAxisAlignment: isUser
              ? CrossAxisAlignment.end
              : CrossAxisAlignment.start,
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
                crossAxisAlignment: isUser
                    ? CrossAxisAlignment.end
                    : CrossAxisAlignment.start,
                children: [
                  Text(
                    message.text,
                    style: textTheme.bodyLarge!.copyWith(
                      color: Colors.white,
                      fontSize: 14.sp,
                    ),
                  ),
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
            )
                .animate()
                .fadeIn(duration: 400.ms, curve: Curves.easeInOut)
                .slideX(
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

  Widget _buildTypingIndicator() {
    return Container(
      padding: EdgeInsets.all(12.w),
      decoration: BoxDecoration(
        color: AppColors.secondary.withOpacity(0.1),
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(16.r),
          bottomLeft: Radius.circular(4.r),
          bottomRight: Radius.circular(16.r),
          topRight: Radius.circular(16.r),
        ),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          _buildDot(),
          SizedBox(width: 4.w),
          _buildDot(delay: 200.ms),
          SizedBox(width: 4.w),
          _buildDot(delay: 400.ms),
        ],
      ),
    ).animate().fadeIn(duration: 300.ms);
  }

  Widget _buildDot({Duration delay = Duration.zero}) {
    return Container(
      width: 8.w,
      height: 8.w,
      decoration: const BoxDecoration(
        color: AppColors.primary,
        shape: BoxShape.circle,
      ),
    ).animate().scale(duration: 600.ms, delay: delay, curve: Curves.easeInOut);
  }
}
