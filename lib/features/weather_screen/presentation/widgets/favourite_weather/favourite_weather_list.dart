import 'package:aviation_app/features/weather_screen/presentation/widgets/weather_card/weather_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../riverpod/weather_notifier.dart';

class FavouriteWeathersList extends StatelessWidget {
  const FavouriteWeathersList({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer(
      builder: (_, ref, _) {
        final weatherState = ref.watch(weatherProvider);

        return weatherState.favouriteWeatherList.isNotEmpty
            ? ListView.builder(
          padding: EdgeInsets.zero,
                itemCount: weatherState.favouriteWeatherList.length,
                physics: NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemBuilder: (_, index) {
                  final weather = weatherState.favouriteWeatherList.toList()[index];

                  return Container(
                    margin: EdgeInsets.only(bottom: 12.h),
                    child: GestureDetector(
                        onTap: ()=> ref.read(weatherProvider.notifier).onExpand(index),
                        child: WeatherCard(weather: weather, isExpand: weatherState.expandedIndex == index,)),
                  );
                },
              )
            : SizedBox.shrink();
      },
    );
  }
}
