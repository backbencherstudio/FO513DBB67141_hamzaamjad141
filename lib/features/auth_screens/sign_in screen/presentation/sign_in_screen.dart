import 'package:aviation_app/core/constant/icons.dart';
import 'package:aviation_app/core/constant/padding.dart';
import 'package:aviation_app/core/routes/route_name.dart';
import 'package:aviation_app/core/utils/utils.dart';
import 'package:aviation_app/features/auth_screens/sign_in%20screen/presentation/widget/customForgetME_section.dart';
import 'package:aviation_app/features/auth_screens/sign_in%20screen/presentation/widget/custom_textformfiled.dart';
import 'package:aviation_app/features/auth_screens/sign_in%20screen/presentation/widget/richtext.dart';
import 'package:aviation_app/features/create_screen/create_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

import '../../sign_Up screen/presentation/widgets/customContainer.dart';
import '../../sign_Up screen/presentation/widgets/or_vector.dart';

class SignInScreen extends StatelessWidget {
  const SignInScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final TextEditingController emailController = TextEditingController();
    final TextEditingController passwordController = TextEditingController();
    return CreateScreen(
      child: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(height: 65.h),
            Text(
              "LEFT SEAT LESSONS",
              style: Theme.of(context).textTheme.headlineSmall,
            ),
            SizedBox(height: 92.h),
            Text(
              "Log in",
              style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                fontSize: 32.sp,
                fontWeight: FontWeight.w100,
              ),
            ),
            Text(
              "Welcome back, Please login",
              style: Theme.of(context).textTheme.titleSmall!.copyWith(
                fontWeight: FontWeight.w400,
                color: Color(0xffA5A5AB),
              ),
            ),
            SizedBox(height: 48.h),
            CustomTextformfiled(
              text: "Email",
              hintext: "Enter your email",
              icons: AppIcons.message,
              controller: emailController,
            ),
            SizedBox(height: 18.h),
            CustomTextformfiled(
              text: "Password",
              isobscure: true,
              hintext: "Enter your password",
              icons: AppIcons.eye,
              controller: passwordController,
            ),
            SizedBox(height: 36.h),
            Padding(
              padding: AppPadding.screenHorizontal,
              child: Utils.primaryButton(
                text: "Continue",
                height: 54.h,
                onPressed: () {
                  context.go(RouteName.weatherScreen);
                },
              ),
            ),
            SizedBox(height: 24.h),
            CustomforgetmeSection(),
            SizedBox(height: 36.h),
            OrVector(),
            SizedBox(height: 24.h),
            GoogleLoginButton(
              text: 'Continue With Google',
              img: AppIcons.google,
            ),
            SizedBox(height: 64.h),
            SignInOrSignUp(
              text: 'Sign up',
              onTap: () {
                context.push(RouteName.signupScreen);
              },
            ),

            SizedBox(height: 100.h),
          ],
        ),
      ),
    );
  }
}
