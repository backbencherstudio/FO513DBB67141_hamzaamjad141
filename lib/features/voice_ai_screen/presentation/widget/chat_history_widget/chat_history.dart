import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../core/constant/padding.dart';
import '../../../../../core/theme/theme_extension/app_colors.dart';
import '../../../data/entity/chat_message_state.dart';
import 'build_bubble.dart';
import 'build_type_indicator.dart';

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
          color: AppColors.secondary.withValues(alpha: 0.05),
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
                    return buildChatBubble(context, message, index);
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
                      child: buildTypingIndicator(),
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

}