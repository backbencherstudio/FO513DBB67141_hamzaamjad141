import 'package:aviation_app/core/constant/icons.dart';
import 'package:aviation_app/features/auth_screens/sign_up%20screen/presentation/widget/customForgetME_section.dart';
import 'package:aviation_app/features/auth_screens/sign_up%20screen/presentation/widget/custom_dummy_button.dart';
import 'package:aviation_app/features/auth_screens/sign_up%20screen/presentation/widget/custom_textformfiled.dart';
import 'package:aviation_app/features/create_screen/create_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SignupScreen extends StatelessWidget {
  
  const SignupScreen({super.key});

  @override
  Widget build(BuildContext context) {

    final TextEditingController emailController = TextEditingController();
      final TextEditingController passwordController = TextEditingController();
    return CreateScreen(
      child: Column(
        children: [
          SizedBox(height: 55.h),
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
          CustomTextformfiled(text: "Email" , icons: AppIcons.message, controller: emailController),
          SizedBox(height: 18.h,),
          CustomTextformfiled(text: "Password" ,icons:AppIcons.eye , controller: passwordController),
          CustomDummyButton(onTap: (){},text: "Continue",),
          CustomforgetmeSection(),

        ],
      ),
    );
  }
}
