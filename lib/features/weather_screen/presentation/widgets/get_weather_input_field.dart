import 'package:aviation_app/core/utils/common_widget/common_widget.dart';
import 'package:aviation_app/features/weather_screen/riverpod/weather_notifier.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/theme/theme_extension/app_colors.dart';
import '../../../../core/utils/common_widget/primary_button/primary_button.dart';

class GetWeatherInputField extends StatelessWidget {
  final TextEditingController textEditingController;
  final FocusNode focusNode;
  const GetWeatherInputField({
    super.key,
    required this.textEditingController,
    required this.focusNode,
  });

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Container(
      width: 327.w,
      padding: EdgeInsets.all(16.r),
      decoration: BoxDecoration(
        color: AppColors.secondary,
        border: Border.all(color: Colors.white.withValues(alpha: 0.1)),
        borderRadius: BorderRadius.circular(8.r),
      ),
      child: Column(
        children: [
          Container(
            width: double.infinity,
            padding: EdgeInsets.symmetric(vertical: 13.h, horizontal: 19.w),
            decoration: BoxDecoration(
              color: AppColors.surface,
              borderRadius: BorderRadius.circular(8.r),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Align(
                  alignment: Alignment.topLeft,
                  child: Text(
                    "ICAO Code",
                    style: textTheme.bodyMedium?.copyWith(
                      color: AppColors.secondaryTextColor,
                    ),
                  ),
                ),
                Align(
                  alignment: Alignment.topLeft,
                  child: TextFormField(
                    controller: textEditingController,
                    style: textTheme.bodyMedium,
                    focusNode: focusNode,
                    onTapOutside: (_) => focusNode.unfocus(),
                    decoration: InputDecoration(hintText: "Enter ICAO code"),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 20.h),

          SizedBox(
            width: double.infinity,
            child: Consumer(
              builder: (_, ref, _) {
                final weatherNotifier = ref.read(weatherProvider.notifier);
                return PrimaryButton(
                  bodyText: "Get Weather",
                  onTap: () {
                    if(textEditingController.text.isNotEmpty){
                      weatherNotifier.onTabChange(0);
                      weatherNotifier.onGetWeather(searchCommand: textEditingController.text);

                    }
                  },
                );
              }
            ),
          ),
        ],
      ),
    );
  }
}
