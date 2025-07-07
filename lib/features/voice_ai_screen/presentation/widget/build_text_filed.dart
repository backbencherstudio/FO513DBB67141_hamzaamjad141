import 'package:aviation_app/core/theme/theme_extension/app_colors.dart';
import 'package:aviation_app/core/utils/common_widget/common_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../data/provider/chat_bot_provider/chat_bot_provider.dart';


class BuildTextFiled extends HookConsumerWidget {
  final TextEditingController? messageController;

  const BuildTextFiled({super.key, this.messageController});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    TextTheme textTheme = Theme.of(context).textTheme;

    // Create an animation controller using hooks
    final animationController = useAnimationController(
      duration: const Duration(milliseconds: 300),
    );

    // Create a scale animation
    final scaleAnimation = Tween<double>(begin: 0.8, end: 1.0).animate(
      CurvedAnimation(parent: animationController, curve: Curves.easeInOut),
    );

    // Start the animation when the widget mounts
    useEffect(() {
      animationController.forward();
      return null;
    }, const []);

    return ScaleTransition(
      scale: scaleAnimation,
      child: Container(
        padding: const EdgeInsets.all(1),
        decoration: BoxDecoration(
          gradient: const LinearGradient(
            colors: [
              Colors.white,
              Colors.transparent,
              Colors.white,
              Colors.transparent,
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            stops: [0.0, 0.05, 0.7, 1.0],
          ),
          borderRadius: BorderRadius.circular(12.r),
        ),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12.r),
            color: AppColors.secondary,
          ),
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12.r),
              color: Colors.white10,
            ),
            child: Container(
              height: 50.h,
              padding: EdgeInsets.symmetric(horizontal: 16.w),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    AppColors.primary.withValues(alpha: 0.08),
                    const Color(0xff23293D).withValues(alpha: 0.7),
                    const Color(0xff23293D).withValues(alpha: 0.7),
                    AppColors.primary.withValues(alpha: 0.08),
                  ],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  stops: const [0.0, 0.25, 0.75, 1.0],
                ),
                borderRadius: BorderRadius.circular(12.r),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Expanded(
                    child: TextField(
                      controller: messageController,
                      decoration: InputDecoration(
                        filled: false,
                        hintText: 'Type your question here...',
                        hintStyle: textTheme.bodyMedium!.copyWith(
                          color: Colors.white,
                          fontSize: 14.sp,
                        ),
                        border: InputBorder.none,
                        contentPadding: EdgeInsets.zero,
                      ),
                      style: textTheme.bodyMedium!.copyWith(
                        color: Colors.white,
                        fontSize: 14.sp,
                      ),
                      textAlign: TextAlign.left,
                    ),
                  ),
                  SizedBox(width: 5.w),
                  GestureDetector(
                    onTap: () {
                      final message = messageController?.text.trim();
                      if (message != null && message.isNotEmpty) {
                        /// Call the provider to send the message
                        ref.read(voiceAiProvider.notifier).getGeminiResponse(message);
                        messageController?.clear(); // Clear the text field
                      }
                    },
                    child: CommonWidget.secondaryButton(
                      child: SvgPicture.asset('assets/icons/send.svg'),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}