import 'package:aviation_app/core/utils/common_widget/common_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../core/theme/theme_extension/app_colors.dart';
import '../../../../../core/utils/common_widget/primary_button/primary_button.dart';

class WeatherResult extends StatelessWidget {
  const WeatherResult({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          spacing: 12.w,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: PrimaryButton(
                onTap: () {},
                bodyText: "Home Base",
                backgroundColor: AppColors.surface,
                borderColor: Colors.transparent,
                dots: false,
                isActive: false,
                textStyle: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: AppColors.deActiveTextColor,
                ),
              ),
            ),
            Expanded(
              child: PrimaryButton(
                onTap: () {},
                bodyText: "Favorites",
                dots: false,
                isActive: false,
                backgroundColor: AppColors.surface,
                borderColor: Colors.transparent,
                textStyle: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: AppColors.deActiveTextColor,
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
