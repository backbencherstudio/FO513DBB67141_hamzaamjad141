import 'package:aviation_app/core/theme/theme_extension/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../data/provider/text_filed_to_voice.dart';

class TextFieldToggle extends ConsumerWidget {
  final String svgAsset; // Path to SVG asset (e.g., AppIcons.keyboardStroke)

  const TextFieldToggle({
    super.key,
    required this.svgAsset,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isActive = ref.watch(showTextFieldProvider);

    return GestureDetector(
      onTap: () {
        ref.read(showTextFieldProvider.notifier).state = !isActive;
        debugPrint('Toggled showTextField: ${!isActive}');
      },
      child: Container(
        width: 60.0.w,
        padding: EdgeInsets.all(2),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(40.0),
          color: isActive ? AppColors.primary : AppColors.secondary,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.3),
              blurRadius: 4.0,
              offset: Offset(0, 2),
            ),
          ],
        ),
        child: Stack(
          alignment: Alignment.center,
          children: [
            AnimatedAlign(
              duration: const Duration(milliseconds: 300),
              curve: Curves.easeInOut,
              alignment: isActive ? Alignment.centerRight : Alignment.centerLeft,
              child: Container(
                width: 30.0,
                height: 30.0,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: AppColors.onPrimary,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.3),
                      blurRadius: 4.0,
                      offset: Offset(0, 2),
                    ),
                  ],
                ),
                child: Center(
                  child: SvgPicture.asset(
                    svgAsset,
                    width: 16.0,
                    height: 16.0,
                    colorFilter: ColorFilter.mode(
                      isActive ? AppColors.onError : AppColors.onSecondary,
                      BlendMode.srcIn,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}