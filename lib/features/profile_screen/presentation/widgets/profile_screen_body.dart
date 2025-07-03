import 'package:aviation_app/core/constant/padding.dart';
import 'package:aviation_app/core/routes/route_name.dart';
import 'package:aviation_app/core/theme/theme_extension/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

class ProfileScreenBody extends StatelessWidget {
  const ProfileScreenBody({super.key});

  Widget customListTile({
    required TextTheme textTheme,
    required String titleText,
    required VoidCallback onTap,
    Widget? trailing,
  }) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 13.w, vertical: 8.h),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(8.r),
      ),
      child: ListTile(
        contentPadding: EdgeInsets.zero,
        onTap: () {
          onTap();
        },
        leading: Text(titleText, style: textTheme.bodyMedium),
        trailing: trailing ?? Icon(Icons.arrow_forward_ios),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Padding(
      padding: AppPadding.screenHorizontal,
      child: Column(
        spacing: 12.h,
        children: [
          customListTile(
            textTheme: textTheme,
            titleText: "My account",
            onTap: () {
              context.push(RouteName.editProfileScreen);
            },
          ),
          customListTile(
            textTheme: textTheme,
            titleText: "Subscribe",
            onTap: () {context.push(RouteName.paymentIntro);},
          ),
          customListTile(
            textTheme: textTheme,
            titleText: "My push notifications",
            onTap: () {},
            trailing: Switch(value: true, onChanged: (value) {}),
          ),
        ],
      ),
    );
  }
}
