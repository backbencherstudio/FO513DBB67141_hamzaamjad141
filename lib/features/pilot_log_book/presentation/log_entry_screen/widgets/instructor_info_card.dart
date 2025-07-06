import 'package:aviation_app/core/theme/theme_extension/app_colors.dart';
import 'package:aviation_app/features/pilot_log_book/models/instructor_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../riverpod/log_book_notifier.dart';


class InstructorInfoCard extends StatelessWidget{
  final InstructorModel instructor;
  const InstructorInfoCard({super.key, required this.instructor});

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
      child:      Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("Instructor Info",style: textTheme.titleMedium,),
              SizedBox(height: 8.h,),
              Divider(color: AppColors.secondaryTextColor,),
              SizedBox(height: 16.h,),
              customRichText(
                textTheme: textTheme,
                key: "Name : ",
                value: instructor.name
              ),
              SizedBox(height: 12.h,),
              customRichText(
                  textTheme: textTheme,
                  key: "Email : ",
                  value: instructor.email
              ),
              SizedBox(height: 12.h,),
              customRichText(
                  textTheme: textTheme,
                  key: "Phone : ",
                  value: instructor.phone
              ),
            ],
          )
    );
  }
}