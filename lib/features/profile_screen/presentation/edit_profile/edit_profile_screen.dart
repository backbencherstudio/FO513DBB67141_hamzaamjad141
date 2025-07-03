import 'package:aviation_app/core/constant/icons.dart';
import 'package:aviation_app/core/constant/padding.dart';
import 'package:aviation_app/core/routes/route_name.dart';
import 'package:aviation_app/core/theme/theme_extension/app_colors.dart';
import 'package:aviation_app/core/utils/common_widget/common_widget.dart';
import 'package:aviation_app/core/utils/utils.dart';
import 'package:aviation_app/features/create_screen/create_screen.dart';
import 'package:aviation_app/features/profile_screen/presentation/widgets/profile_screen_header.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'widget/custom_text_field.dart';

class EditProfileScreen extends StatelessWidget {
  const EditProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    TextTheme textTheme = Theme.of(context).textTheme;
    return CreateScreen(
      child: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ProfileScreenHeader(),
              Padding(
                padding: AppPadding.screenHorizontal,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Profile Settings', style: textTheme.bodyLarge),
                    SizedBox(height: 16.h),
                    Container(
                      padding: EdgeInsets.all(16.r),
                      decoration: BoxDecoration(
                        color: AppColors.secondary,
                        borderRadius: BorderRadius.circular(8.r),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        spacing: 12.h,
                        children: [
                          Align(
                            alignment: Alignment.centerRight,
                            child: SvgPicture.asset(
                              AppIcons.editProfile,
                            ),
                          ),
                          CustomTextField(
                            textTheme: textTheme,
                            labelName: 'Fast Name',
                            hintText: 'Enter your fast name',
                          ),
                          CustomTextField(
                            textTheme: textTheme,
                            labelName: 'Last Name',
                            hintText: 'Enter your last name',
                          ),
                          CustomTextField(
                            textTheme: textTheme,
                            labelName: 'Email',
                            hintText: 'Enter your email',
                          ),
                          CustomTextField(
                            textTheme: textTheme,
                            labelName: 'Old Password',
                            hintText: 'Enter old password',
                          ),
                          CustomTextField(
                            textTheme: textTheme,
                            labelName: 'New Password',
                            hintText: 'Enter your new password',
                          ),
                          CustomTextField(
                            textTheme: textTheme,
                            labelName: 'Confirm Password',
                            hintText: 'Enter your new password',
                          ),
                          Utils.primaryButton(
                            onPressed: () {},
                            text: 'Save Change',
                          ),
                          Utils.primaryButton(
                            onPressed: () {},
                            backgroundColor: AppColors.surface,
                            text: 'Delete my account ',
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 40.h),
                  ],
                ),
              ),
              SizedBox(height: 145.h,)
            ],
          ),
        ),
      ),
    );
  }
}
