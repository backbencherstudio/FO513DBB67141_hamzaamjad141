import 'package:aviation_app/core/constant/icons.dart';
import 'package:aviation_app/core/utils/common_widget/common_widget.dart';
import 'package:aviation_app/core/utils/common_widget/primary_button/primary_button.dart';
import 'package:aviation_app/features/weather_screen/model/weather_model.dart';
import 'package:aviation_app/features/weather_screen/presentation/widgets/weather_card/weather_card_custom_list_tile.dart';
import 'package:aviation_app/features/weather_screen/presentation/widgets/weather_card/weather_card_header.dart';
import 'package:aviation_app/features/weather_screen/riverpod/weather_notifier.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';

import '../../../../../core/theme/theme_extension/app_colors.dart';

class WeatherCard extends StatelessWidget {
  final WeatherModel weather;
  final bool isExpand;

  const WeatherCard({super.key, required this.weather, this.isExpand = true});

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return AnimatedSize(
      curve: Curves.fastOutSlowIn,
      duration: Duration(milliseconds: 400),
      child: Container(
        padding: EdgeInsets.all(16.r),
        width: double.infinity,
        decoration: BoxDecoration(
          color: AppColors.secondary,
          borderRadius: BorderRadius.circular(8.r),
          border: Border.all(color: Colors.white.withValues(alpha: 0.3)),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          spacing: 8.h,
          children: [
            WeatherCardHeader(weather: weather),

            if (isExpand)
              Column(
                children: [
                  Divider(color: Colors.white.withValues(alpha: 0.3)),
                  Column(
                    spacing: 12.h,
                    children: [
                      customListTile(
                        textTheme: textTheme,
                        svgIconPath: AppIcons.clockOutline,
                        title: "Time (EST):",
                        body:
                            "${DateFormat('MM/dd/yyyy').format(DateTime.parse(weather.meta?['cache-timestamp']))}, ${DateFormat('hh:mm a').format(DateTime.now())}",
                      ),
                      customListTile(
                        textTheme: textTheme,
                        svgIconPath: AppIcons.airplaneTakeOff,
                        title: "Flight Rules",
                        body: weather.flight_rules ?? "",
                      ),
                      customListTile(
                        textTheme: textTheme,
                        svgIconPath: AppIcons.temperature,
                        title: "Temperature:",
                        body: "${weather.temperature?.value} °C",
                      ),
                      customListTile(
                        textTheme: textTheme,
                        svgIconPath: AppIcons.dewPoint,
                        title: "Dewpoint:",
                        body: "${weather.dewpoint?.value} °C",
                      ),
                      customListTile(
                        textTheme: textTheme,
                        svgIconPath: AppIcons.eyeOutline,
                        title: "Visibility:",
                        body: "${weather.visibility?.value ?? ""} sm",
                      ),
                      customListTile(
                        textTheme: textTheme,
                        svgIconPath: AppIcons.wind,
                        title: "Wind:",
                        body:
                            "${weather.wind_direction?.value}° at ${weather.wind_speed?.value} kt",
                      ),
                      customListTile(
                        textTheme: textTheme,
                        svgIconPath: AppIcons.clouds,
                        title: "Clouds:",
                        body:
                            "Few clouds at ${weather.clouds!.isNotEmpty ? weather.clouds!.first.altitude : ""}",
                      ),
                      customListTile(
                        textTheme: textTheme,
                        svgIconPath: AppIcons.raw,
                        title: "Raw METAR:",
                        body: weather.raw ?? "",
                      ),
                    ],
                  ),
                  SizedBox(height: 15.h),
                  Consumer(
                    builder: (_, ref, _) {
                      final String homeBaseCode =
                          ref.watch(weatherProvider).searchedWeather?.station ??
                          "";
                      final homeBaseButtonLoading = ref
                          .watch(weatherProvider)
                          .homeBaseButtonLoading;
                      return homeBaseButtonLoading
                          ? const Center(child: CircularProgressIndicator())
                          : PrimaryButton(
                              bodyText: "Set As Home Base",
                              onTap: () async {
                                await ref
                                    .read(weatherProvider.notifier)
                                    .setHomeBase(homeBaseCode: homeBaseCode);
                              },
                            );
                    },
                  ),
                ],
              ),
          ],
        ),
      ),
    );
  }
}
