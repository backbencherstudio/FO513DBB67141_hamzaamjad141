import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

import '../../../../../core/constant/icons.dart';
import '../../../../../core/utils/common_widget/common_widget.dart';
import '../../../model/weather_model.dart';
import '../../../riverpod/weather_notifier.dart';

class WeatherCardHeader extends StatelessWidget{
  final WeatherModel weather;
  const WeatherCardHeader({super.key, required this.weather});

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            spacing: 8.h,
            children: [
              Text(
                weather.station?.toUpperCase() ?? "",
                style: textTheme.titleMedium,
              ),
              Container(
                padding: EdgeInsets.symmetric(
                  horizontal: 10.w,
                  vertical: 2.h,
                ),
                decoration: BoxDecoration(
                  color: Colors.yellow,
                  borderRadius: BorderRadius.circular(8.r),
                ),
                child: Text(
                  weather.station?.toUpperCase() ?? "",
                  style: textTheme.bodySmall?.copyWith(
                    color: Color(0xff070707),
                  ),
                ),
              ),
            ],
          ),
          Consumer(
            builder: (_, ref, _) {
              final bool isFavourite = ref.watch(weatherProvider).favouriteWeatherList.any((item)=>item.station == weather.station);
              return CommonWidget.secondaryButton(
                child: SvgPicture.asset(
                  isFavourite ? AppIcons.loveFill : AppIcons.love,
                ),
                onTap: () => ref
                    .read(weatherProvider.notifier)
                    .addToFavouriteWeather(weather: weather),
              );
            },
          ),
        ],
      );
  }
}
