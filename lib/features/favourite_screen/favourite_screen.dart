import 'package:aviation_app/core/constant/icons.dart';
import 'package:aviation_app/core/constant/padding.dart';
import 'package:aviation_app/core/theme/theme_extension/app_colors.dart';
import 'package:aviation_app/core/utils/common_widget/common_widget.dart';
import 'package:aviation_app/features/create_screen/create_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

class FavouriteScreen extends StatelessWidget {
  const FavouriteScreen({super.key});

  @override
  Widget build(BuildContext context) {
    TextTheme textTheme = Theme.of(context).textTheme;
    return Scaffold(
      body: CreateScreen(
        child: SafeArea(
          child: Padding(
            padding: AppPadding.screenHorizontal,
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    CommonWidget.secondaryButton(
                      child: SvgPicture.asset(AppIcons.backIcon),
                    ),
                    Text(
                      'Favourite',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(width: 40.w),
                  ],
                ),
                Expanded(
                  child: ListView.builder(
                    itemCount: 10,
                    itemBuilder: (context, index) {
                      return Container(
                        margin: EdgeInsets.only(bottom: 10.h),
                        padding: EdgeInsetsGeometry.symmetric(
                          horizontal: 12.w,
                          vertical: 12.h,
                        ),
                        decoration: BoxDecoration(
                          color: AppColors.secondary,
                          borderRadius: BorderRadius.circular(12.r),
                          border: Border.all(color: AppColors.secondary),
                        ),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.circular(12.r),
                              child: Image.network(
                                'https://media.istockphoto.com/id/1441416721/photo/male-radio-presenters-having-a-great-time-in-a-studio.jpg?s=612x612&w=0&k=20&c=ZDTMir_JYBsdISpGw8ZpPrIB33D51NWgFxm4Wgqm0B4=',
                                height: 80.h,
                                width: 80.w,
                                fit: BoxFit.cover,
                              ),
                            ),
                            SizedBox(width: 12.w),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Welcome to the podcast',
                                    style: textTheme.titleSmall,
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                  Text(
                                    'hamza.aviator',
                                    style: textTheme.bodySmall!.copyWith(
                                      color: AppColors.secondaryTextColor,
                                    ),
                                  ),
                                  Text(
                                    '5 May - 1 hr 30 min',
                                    style: textTheme.bodySmall!.copyWith(
                                      color: AppColors.secondaryTextColor,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      );

                    }
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
