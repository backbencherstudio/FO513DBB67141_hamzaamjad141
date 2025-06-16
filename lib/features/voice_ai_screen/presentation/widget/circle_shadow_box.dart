import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import '../../../../core/theme/theme_extension/app_colors.dart';
import '../../data/provider/circle_shadow_box_provider.dart';

class CircleShadowBox extends HookConsumerWidget {
  final Widget child;
  final Widget replacement;

  const CircleShadowBox({
    super.key,
    required this.child,
    required this.replacement,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isHolding = useState(false); // Local gesture state

    // Sync with global Riverpod state
    final holdController = ref.read(circleHoldProvider.notifier);

    return GestureDetector(
      onLongPressStart: (_) {
        isHolding.value = true;
        holdController.hold(true);
      },
      onLongPressEnd: (_) {
        isHolding.value = false;
        holdController.hold(false);
      },
      behavior: HitTestBehavior.translucent,
      child: AnimatedSwitcher(
        duration: const Duration(milliseconds: 300), // Animation duration
        transitionBuilder: (Widget child, Animation<double> animation) {
          return ScaleTransition(
            scale: Tween<double>(begin: 0.8, end: 1.0).animate(
              CurvedAnimation(
                parent: animation,
                curve: Curves.easeInOut, // Smooth easing curve
              ),
            ),
            child: FadeTransition(
              opacity: Tween<double>(begin: 0.0, end: 1.0).animate(
                CurvedAnimation(
                  parent: animation,
                  curve: Curves.easeInOut,
                ),
              ),
              child: child,
            ),
          );
        },
        layoutBuilder: (currentChild, previousChildren) {
          return Stack(
            alignment: Alignment.center,
            children: [
              ...previousChildren,
              if (currentChild != null) currentChild,
            ],
          );
        },
        child: isHolding.value
            ? replacement
            : _buildMainBox(child, key: const ValueKey('mainBox')),
      ),
    );
  }

  Widget _buildMainBox(Widget child, {Key? key}) {
    return Container(
      key: key,
      width: 132.h,
      height: 132.h,
      margin: EdgeInsets.all(32.h),
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: const Color(0xFF1D1F2C),
        shape: BoxShape.circle,
        boxShadow: [
          BoxShadow(
            color: AppColors.primary.withValues(alpha: 0.5),
            offset: const Offset(0, 2.938),
            blurRadius: 20.r,
            spreadRadius: 4.r,
          ),
        ],
      ),
      child: child,
    );
  }
}