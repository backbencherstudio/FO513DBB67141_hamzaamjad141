import 'package:aviation_app/core/constant/icons.dart';
import 'package:aviation_app/core/utils/common_widget/common_widget.dart';
import 'package:aviation_app/features/weather_screen/model/weather_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../../../core/theme/theme_extension/app_colors.dart';

class WeatherCard extends StatelessWidget {
  final WeatherModel weather;
  const WeatherCard({super.key, required this.weather});
  
  Widget _customListTile({required TextTheme textTheme,  required String svgIconPath, required String title, required String body}){
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      spacing: 5.w,
      children: [
        SvgPicture.asset(svgIconPath,width: 16.w,height: 16.h,),
        Expanded(
          child: RichText(text: TextSpan(
            text: title,
            style: textTheme.bodySmall?.copyWith(color: Colors.white),
            children: [
              TextSpan(
                text: ' $body',
                style: textTheme.bodySmall?.copyWith(color: Colors.white.withValues(alpha: 0.4))
              )
            ]
          ),),
        )
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Container(
      padding: EdgeInsets.all(16.r),
      width: double.infinity,
      height: 466.h,
      decoration: BoxDecoration(
        color: AppColors.secondary,
        borderRadius: BorderRadius.circular(8.r),
        border: Border.all(color: Colors.white.withValues(alpha: 0.3)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(weather.code.toUpperCase(), style: textTheme.titleMedium),
              CommonWidget.secondaryButton(
                child: Icon(Icons.heart_broken_sharp),
              ),
            ],
          ),
          SizedBox(height: 8.h),

          Divider(color: Colors.white.withValues(alpha: 0.3),),

          SizedBox(height: 8.h,),

          _customListTile(textTheme: textTheme, svgIconPath: AppIcons.clockOutline,title: "Time (EST):",body: weather.time)
        ],
      ),
    );
  }
}
