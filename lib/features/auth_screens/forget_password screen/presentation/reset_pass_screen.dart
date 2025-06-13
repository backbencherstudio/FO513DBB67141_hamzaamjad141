import 'package:aviation_app/core/constant/icons.dart';
import 'package:aviation_app/core/routes/route_name.dart';
import 'package:aviation_app/core/utils/utils.dart';
import 'package:aviation_app/features/auth_screens/sign_in%20screen/presentation/widget/custom_dummy_button.dart';
import 'package:aviation_app/features/auth_screens/sign_in%20screen/presentation/widget/custom_textformfiled.dart';
import 'package:aviation_app/features/auth_screens/sign_in%20screen/presentation/widget/richtext.dart';
import 'package:aviation_app/features/create_screen/create_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

class ResetPassScreen extends StatelessWidget {
  const ResetPassScreen({super.key});

  @override
  Widget build(BuildContext context) {
    TextEditingController passwordController = TextEditingController();
    TextEditingController confirmPasswordController = TextEditingController();

    return CreateScreen(
      child: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(height: 65.h),
            Text(
              "LEFT SEAT LESSONS",
              style: Theme.of(
                context,
              ).textTheme.headlineSmall!.copyWith(fontSize: 24.sp),
            ),
            SizedBox(height: 92.h),
            Text(
              "Reset Your Password",
              style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                fontSize: 32.sp,
                fontWeight: FontWeight.w100,
              ),
            ),
            Text(
              "The password must be different than before",
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.titleSmall!.copyWith(
                fontSize: 18.sp,
                fontWeight: FontWeight.w400,
                color: Color(0xffA5A5AB),
              ),
            ),
            SizedBox(height: 48.h),
            CustomTextformfiled(
              hintext: "Enter your password",
              isobscure: true,
              text: "Password",
              icons: AppIcons.eye,
              controller: passwordController,
            ),
            SizedBox(height: 16.h),
            CustomTextformfiled(
              hintext: "Enter your password",
              isobscure: true,
              text: "password",
              icons: AppIcons.eye,
              controller: confirmPasswordController,
            ),
            SizedBox(height: 36.h),
            CustomDummyButton(
              onTap: () {
                context.push(RouteName.successScreen);
              },
              text: "Continue",
            ),
            SizedBox(height: 16.h),

            Padding(
              padding: EdgeInsetsGeometry.only(left: 24.w, right: 24.w),
              child: Utils.primaryButton(
                onPressed: () {},
                text: "Cancel",
                backgroundColor: Color(0xff1D1F2C),
                height: 54.h,
              ),
            ),
           
           
          ],
        ),
      ),
    );
  }
}
