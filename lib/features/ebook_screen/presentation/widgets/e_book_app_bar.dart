import 'package:aviation_app/core/routes/route_name.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/constant/icons.dart';
import '../../../../core/theme/theme_extension/app_colors.dart';
import '../../../../core/utils/common_widget/common_widget.dart';

class EBookAppBar extends StatelessWidget {
  const EBookAppBar({super.key, required this.textTheme});

  final TextTheme textTheme;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        children: [
          SizedBox(height: 20.h),
          Row(
            spacing: 12.w,
            children: [
              GestureDetector(
                onTap: ()=>context.push(RouteName.profileScreen),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(100),
                  child: Image.network(
                    'https://i.pravatar.cc/150?img=12',
                    height: 47.h,
                    width: 47.h,
                    fit: BoxFit.cover,
                    loadingBuilder: (context, child, loadingProgress) {
                      if (loadingProgress == null) {
                        return child; // Image loaded successfully
                      } else {
                        return Center(
                          child: CircularProgressIndicator(
                            value: loadingProgress.expectedTotalBytes != null
                                ? loadingProgress.cumulativeBytesLoaded /
                                      (loadingProgress.expectedTotalBytes ?? 1)
                                : null,
                          ),
                        );
                      }
                    },
                    errorBuilder: (context, error, stackTrace) {
                      // Fallback widget in case of error
                      return Center(
                        child: Icon(Icons.error, color: Colors.red, size: 40.sp),
                      );
                    },
                  ),
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Good Morning,',
                    style: textTheme.labelLarge!.copyWith(
                      color: AppColors.primary,
                    ),
                  ),
                  Text('Ronald Richards'),
                ],
              ),
              //const Spacer(),
              // CommonWidget.secondaryButton(
              //   child: SvgPicture.asset(AppIcons.love),
              // ),
            ],
          ),
        ],
      ),
    );
  }
}
