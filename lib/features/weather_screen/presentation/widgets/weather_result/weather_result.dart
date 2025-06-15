import 'package:aviation_app/core/utils/common_widget/common_widget.dart';
import 'package:aviation_app/features/weather_screen/riverpod/weather_notifier.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hive_flutter/adapters.dart';

import '../../../../../core/theme/theme_extension/app_colors.dart';
import '../../../../../core/utils/common_widget/primary_button/primary_button.dart';
import '../favourite_weather/favourite_weather_list.dart';
import '../weather_card/weather_card.dart';

class WeatherResult extends StatefulWidget {
  const WeatherResult({super.key});

  @override
  State<WeatherResult> createState() => _WeatherResultState();
}

class _WeatherResultState extends State<WeatherResult>
    with SingleTickerProviderStateMixin {
  late final TabController _tabController;

  @override
  void initState() {
    _tabController = TabController(length: 2, vsync: this);
    super.initState();
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Column(
      children: [
        Row(
          spacing: 12.w,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: Consumer(
                builder: (_, ref, _) {
                  final weatherState = ref.watch(weatherProvider);
                  final weatherNotifier = ref.read(weatherProvider.notifier);
                  debugPrint(
                    "\nResult : ${weatherState.searchedWeather == null ? 'null' : 'not null'}\n",
                  );
                  return PrimaryButton(
                    onTap: () {
                      weatherNotifier.onTabChange(0);
                    },
                    bodyText: "Home Base",
                    backgroundColor:
                        (weatherState.selectedTab == 0 &&
                            weatherState.searchedWeather != null)
                        ? Colors.white
                        : AppColors.surface,
                    borderColor: Colors.transparent,
                    dots: false,
                    textStyle: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      color:
                          (weatherState.selectedTab == 0 &&
                              weatherState.searchedWeather != null)
                          ? Color(0xff070707)
                          : AppColors.deActiveTextColor,
                    ),
                  );
                },
              ),
            ),
            Expanded(
              child: Consumer(
                builder: (_, ref, _) {
                  final weatherState = ref.watch(weatherProvider);
                  return PrimaryButton(
                    onTap: () {
                      ref.read(weatherProvider.notifier).onTabChange(1);
                    },
                    bodyText: "Favorites",
                    dots: false,
                    backgroundColor: weatherState.selectedTab == 1
                        ? Colors.white
                        : AppColors.surface,
                    borderColor: Colors.transparent,
                    textStyle: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      color: weatherState.selectedTab == 1
                          ? Color(0xff070707)
                          : AppColors.deActiveTextColor,
                    ),
                  );
                },
              ),
            ),
          ],
        ),
        SizedBox(height: 18.h),

        Consumer(
          builder: (_, ref, _) {
            final weatherState = ref.watch(weatherProvider);
            return weatherState.selectedTab == 0
                ? ((weatherState.searchCommand != null) &&
                          (weatherState.isWeatherFound == false)
                      ? Container(
                          width: double.infinity,
                          padding: EdgeInsets.all(16.r),
                          decoration: BoxDecoration(
                            color: Colors.red.withValues(alpha: 0.09),
                            borderRadius: BorderRadius.circular(8.r),
                            border: Border.all(
                              color: Colors.red.withValues(alpha: 0.2),
                            ),
                          ),
                          child: Text(
                            "Error fetching weather:\nWeather not found",
                            style: textTheme.bodyMedium?.copyWith(
                              color: Colors.red,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        )
                      : (weatherState.searchCommand != null) &&
                            (weatherState.isWeatherFound == true)
                      ? WeatherCard(weather: weatherState.searchedWeather!)
                      : SizedBox.shrink())
                : FavouriteWeathersList();
          },
        ),
      ],
    );
  }
}
