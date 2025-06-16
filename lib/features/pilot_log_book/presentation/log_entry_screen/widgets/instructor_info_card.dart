import 'package:aviation_app/core/theme/theme_extension/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';


class InstructorInfoCard extends StatelessWidget{
  const InstructorInfoCard({super.key});

  Widget customRichText({required TextTheme textTheme, required String key, required String value}){
    return  RichText(
      text: TextSpan(
          text: key,
          style: textTheme.bodyMedium,
          children: [
            TextSpan(
                text: value,
                style: textTheme.bodyMedium?.copyWith(
                    color: AppColors.secondaryTextColor
                )
            )
          ]
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(16.r),
      decoration: BoxDecoration(
        color: AppColors.secondary,
        borderRadius: BorderRadius.circular(8.r),
        border: Border.all(color: Colors.white.withValues(alpha: 0.25))
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("Instructor Info",style: textTheme.titleMedium,),
          SizedBox(height: 8.h,),
          Divider(color: AppColors.secondaryTextColor,),
          SizedBox(height: 16.h,),
          customRichText(
            textTheme: textTheme,
            key: "Name : ",
            value: "Nahidul Islam Shakin"
          ),
          SizedBox(height: 12.h,),
          customRichText(
              textTheme: textTheme,
              key: "Email : ",
              value: "nahidulislamshakin926@gmail.com"
          ),
          SizedBox(height: 12.h,),
          customRichText(
              textTheme: textTheme,
              key: "Phone : ",
              value: "01954841508"
          ),
        ],
      ),
    );
  }
}