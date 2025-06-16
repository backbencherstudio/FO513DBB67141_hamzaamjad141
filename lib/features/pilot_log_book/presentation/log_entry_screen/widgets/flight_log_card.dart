import 'package:aviation_app/core/theme/theme_extension/app_colors.dart';
import 'package:aviation_app/core/utils/common_widget/primary_button/primary_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class FlightLogCard extends StatelessWidget {
  final String from;
  final String to;
  final String date;
  final String status;
  final String flightName;
  final String flightTime;
  final String day;
  final String night;
  final String ifr;
  final String crossCountry;
  final String takeOffs;
  final String landings;
  const FlightLogCard({
    super.key,
    required this.from,
    required this.to,
    required this.date,
    required this.status,
    required this.flightName,
    required this.flightTime,
    required this.day,
    required this.night,
    required this.ifr,
    required this.crossCountry,
    required this.takeOffs,
    required this.landings,
  });

  Widget customRichText(TextTheme textTheme, String key, String value) {
    return RichText(
      text: TextSpan(
        text: key,
        style: textTheme.bodySmall,
        children: [
          TextSpan(
            text: value,
            style: textTheme.bodySmall?.copyWith(
              color: AppColors.secondaryTextColor,
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Container(
      padding: EdgeInsets.all(16.r),
      decoration: BoxDecoration(
        color: AppColors.secondary,
        borderRadius: BorderRadius.circular(8.r),
        border: Border.all(color: Colors.white.withValues(alpha: 0.25)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            spacing: 4.w,
            children: [
              Text(from, style: textTheme.titleMedium),
              Icon(Icons.arrow_forward, color: AppColors.primary),
              Text(to, style: textTheme.titleMedium),
            ],
          ),
          SizedBox(height: 6.h),
          Text(
            date,
            style: textTheme.bodySmall?.copyWith(
              color: AppColors.secondaryTextColor,
            ),
          ),
          SizedBox(height: 8.h),
          Divider(color: AppColors.secondaryTextColor),
          SizedBox(height: 16.h),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            spacing: 12.h,
            children: [
              customRichText(textTheme, "Flight Name : ", flightName),
              customRichText(textTheme, "Flight Time : ", flightTime),
              customRichText(textTheme, "Day : ", day),
              customRichText(textTheme, "Night : ", night),
              customRichText(textTheme, "IFR : ", ifr),
              customRichText(textTheme, "Cross Country : ", crossCountry),
              customRichText(textTheme, "Take Offs : ", takeOffs),
              customRichText(textTheme, "Landings : ", landings),
            ],
          ),
          SizedBox(height: 16.h),
          PrimaryButton(
            bodyText: "Delete",
            onTap: () {},
            backgroundColor: Colors.red,
            dots: false,
            borderColor: Colors.transparent,
          )
        ],
      ),
    );
  }
}
