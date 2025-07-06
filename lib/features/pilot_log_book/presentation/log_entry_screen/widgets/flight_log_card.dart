import 'package:aviation_app/core/theme/theme_extension/app_colors.dart';
import 'package:aviation_app/core/utils/common_widget/primary_button/primary_button.dart';
import 'package:aviation_app/features/pilot_log_book/models/log_request_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class FlightLogCard extends StatelessWidget {

  final LogRequestModel logRequestModel;
  const FlightLogCard({
    super.key,
    required this.logRequestModel,
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
      margin: EdgeInsets.only(bottom: 15.h),
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
              Text(logRequestModel.from, style: textTheme.titleMedium),
              Icon(Icons.arrow_forward, color: AppColors.primary),
              Text(logRequestModel.to, style: textTheme.titleMedium),
              Spacer(),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 2.h),
                decoration: BoxDecoration(
                  color: logRequestModel.status == 'PENDING' ?  Color(0xffFFF9E5) :   Color(0xffF5FFFA),
                  borderRadius: BorderRadius.circular(4.r),
                ),
                child: Text(logRequestModel.status,style: textTheme.bodySmall?.copyWith(
                  color:  logRequestModel.status == 'PENDING' ? Color(0xffD5B032) : Color(0xff46B277),
                ),),
              ),
            ],
          ),
          SizedBox(height: 6.h),
          Text(
            logRequestModel.date,
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
              customRichText(textTheme, "Flight Name : ", logRequestModel.flightTime),
              customRichText(textTheme, "Flight Time : ", logRequestModel.flightTime),
              customRichText(textTheme, "Day : ", logRequestModel.daytime),
              customRichText(textTheme, "Night : ", logRequestModel.nightime),
              customRichText(textTheme, "IFR : ", logRequestModel.ifrtime),
              customRichText(textTheme, "Cross Country : ", logRequestModel.crossCountry),
              customRichText(textTheme, "Take Offs : ", logRequestModel.takeoffs.toString()),
              customRichText(textTheme, "Landings : ", logRequestModel.landings.toString()),
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
