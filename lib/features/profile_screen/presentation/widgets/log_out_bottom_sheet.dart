import 'package:aviation_app/core/routes/route_name.dart';
import 'package:aviation_app/core/utils/common_widget/primary_button/primary_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

Future<void> logOutBottomSheet({required BuildContext context}) async {
  await showModalBottomSheet(
    isScrollControlled: true,
    useSafeArea: true,
    backgroundColor: Color(0xff070707),
    context: context,
    builder: (_) {
      final textTheme = Theme.of(context).textTheme;
      return Container(
        width: 375.w,
        height: 350.h,
        padding: EdgeInsets.only(
          left: 24.w,
          right: 24.w,
          top: 20.h,
          bottom: 32.h,
        ),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Color(0xff2D3D99).withValues(alpha: 0.25),
              Color(0xff070707),
            ],
          ),
          //  color: Color(0xff2D3D99),
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(12.r),
            topRight: Radius.circular(12.r),
          ),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Align(
              alignment: Alignment.topRight,
              child: IconButton(
                onPressed: () => context.pop(),
                icon: Icon(Icons.close, size: 30.sp),
              ),
            ),
            Text(
              "Are you sure you want\nto logout?",
              style: textTheme.titleMedium,
              textAlign: TextAlign.center,
            ),
            Spacer(),
            PrimaryButton(
              bodyText: "Yes, I want to Logout",
              onTap: () => context.go(RouteName.signInScreen),
            ),
            SizedBox(height: 16.h),
            PrimaryButton(
              bodyText: "No, Stay Logged In",
              isSecondary: true,
              onTap: () => Navigator.pop(context),
            ),
          ],
        ),
      );
    },
  );
}
