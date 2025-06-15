import 'package:aviation_app/core/constant/icons.dart';
import 'package:aviation_app/core/utils/common_widget/common_widget.dart';
import 'package:aviation_app/core/utils/common_widget/primary_button/primary_button.dart';
import 'package:aviation_app/features/weather_screen/model/weather_model.dart';
import 'package:aviation_app/features/weather_screen/riverpod/weather_notifier.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../../../core/theme/theme_extension/app_colors.dart';

class WeatherCard extends StatelessWidget {
  final WeatherModel weather;
  const WeatherCard({super.key, required this.weather});

  Widget _customListTile({
    required TextTheme textTheme,
    required String svgIconPath,
    required String title,
    required String body,
  }) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      spacing: 5.w,
      children: [
        SvgPicture.asset(svgIconPath, width: 16.w, height: 16.h),
        Expanded(
          child: RichText(
            text: TextSpan(
              text: title,
              style: textTheme.bodySmall?.copyWith(color: Colors.white),
              children: [
                TextSpan(
                  text: ' $body',
                  style: textTheme.bodySmall?.copyWith(
                    color: Colors.white.withValues(alpha: 0.4),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Container(
      padding: EdgeInsets.all(16.r),
      width: double.infinity,
      // height: 466.h,
      decoration: BoxDecoration(
        color: AppColors.secondary,
        borderRadius: BorderRadius.circular(8.r),
        border: Border.all(color: Colors.white.withValues(alpha: 0.3)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: 8.h,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(weather.code.toUpperCase(), style: textTheme.titleMedium),
              Consumer(
                builder: (_, ref, _) {
                  return CommonWidget.secondaryButton(
                    child:  SvgPicture.asset( weather.isFavorite ? AppIcons.loveFill : AppIcons.love),
                    onTap: ()=> ref.read(weatherProvider.notifier).onAddToFavouriteWeather(weather: weather),
                  );
                }
              ),
            ],
          ),

          Divider(color: Colors.white.withValues(alpha: 0.3)),

          Column(
            spacing: 12.h,
            children: [
              _customListTile(
                textTheme: textTheme,
                svgIconPath: AppIcons.clockOutline,
                title: "Time (EST):",
                body: weather.time,
              ),
              _customListTile(
                textTheme: textTheme,
                svgIconPath: AppIcons.airplaneTakeOff,
                title: "Flight Rules",
                body: weather.flightRules,
              ),
              _customListTile(
                textTheme: textTheme,
                svgIconPath: AppIcons.temperature,
                title: "Temperature:",
                body: weather.temperature,
              ),
              _customListTile(
                textTheme: textTheme,
                svgIconPath: AppIcons.dewPoint,
                title: "Dewpoint:",
                body: weather.dewPoint,
              ),
              _customListTile(
                textTheme: textTheme,
                svgIconPath: AppIcons.eyeOutline,
                title: "Visibility:",
                body: weather.visibility,
              ),
              _customListTile(
                textTheme: textTheme,
                svgIconPath: AppIcons.wind,
                title: "Wind",
                body: weather.wind,
              ),
              _customListTile(
                textTheme: textTheme,
                svgIconPath: AppIcons.clouds,
                title: "Clouds",
                body: weather.clouds,
              ),
              _customListTile(
                textTheme: textTheme,
                svgIconPath: AppIcons.raw,
                title: "Raw METAR",
                body: weather.rawMetar,
              ),
            ],
          ),

          SizedBox(height: 4.h),
          PrimaryButton(bodyText: "Set As Home Base", onTap: () {}),
        ],
      ),
    );
  }
}
