import 'package:aviation_app/core/constant/icons.dart';
import 'package:aviation_app/core/constant/images.dart';
import 'package:aviation_app/core/theme/theme_extension/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/constant/padding.dart';
import '../../../../core/utils/common_widget/common_widget.dart';

class ProfileScreenHeader extends StatelessWidget {
  const ProfileScreenHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      spacing: 12.h,
      children: [

        /// Back button
        Padding(
          padding: AppPadding.screenHorizontal,
          child: Align(
            alignment: Alignment.topLeft,
            child: SafeArea(
              child: CommonWidget.secondaryButton(
                onTap: () => context.pop(),
                child: Icon(Icons.arrow_back),
              ),
            ),
          ),
        ),

        /// Profile Picture
        SizedBox(
          width: 108.w,
          height: 111.h,
          child: Stack(
            fit: StackFit.expand,
            children: [
              Image.asset(AppImages.men, fit: BoxFit.contain),
              Align(
                alignment: Alignment.bottomRight,
                child: GestureDetector(
                  onTap: () {},
                  child: SvgPicture.asset(AppIcons.edit),
                ),
              ),
            ],
          ),
        ),

        /// User Name
        Text("Nahidul Islam Shakin",style:Theme.of(context).textTheme.headlineSmall),

        Divider(color: AppColors.secondaryTextColor.withValues(alpha: 0.4),)
      ],
    );
  }
}
