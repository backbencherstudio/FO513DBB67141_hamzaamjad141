import 'package:aviation_app/core/constant/icons.dart';
import 'package:aviation_app/core/routes/route_name.dart';
import 'package:aviation_app/features/auth_screens/sign_in%20screen/presentation/widget/custom_dummy_button.dart';
import 'package:aviation_app/features/auth_screens/sign_in%20screen/presentation/widget/custom_textformfiled.dart';
import 'package:aviation_app/features/auth_screens/sign_in%20screen/presentation/widget/richtext.dart';
import 'package:aviation_app/features/create_screen/create_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

class SignupScreen extends StatelessWidget {
  const SignupScreen({super.key});

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
            SizedBox(height: 50.h),
            Text(
              "Sign up",
              style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                fontSize: 32.sp,
                fontWeight: FontWeight.w100,
              ),
            ),
            Text(
              "Create an account",
              style: Theme.of(context).textTheme.titleSmall!.copyWith(
                fontWeight: FontWeight.w400,
                color: Color(0xffA5A5AB),
              ),
            ),
            SizedBox(height: 48.h),
            CustomTextformfiled(text: "Name" ,hintext: "Enter your name", icons: AppIcons.user, controller: emailController),
            SizedBox(height: 18.h,),
            CustomTextformfiled(text: "Email" ,hintext: "Enter your email", icons: AppIcons.message, controller: emailController),
            SizedBox(height: 18.h,),
            CustomTextformfiled(text: "Current License" ,hintext: "No License", icons: AppIcons.dropdown, controller: emailController),
            SizedBox(height: 18.h,),
            CustomTextformfiled(text: "Password" ,hintext: "Enter your password", icons: AppIcons.eye, controller: emailController),
            SizedBox(height: 18.h,),
            CustomTextformfiled(text: "Confirm Password" ,hintext: "Enter your password", icons:AppIcons.eye , controller: passwordController),
            SizedBox(height: 36.h,),
            CustomDummyButton(onTap: (){
            context.push(RouteName.signUpOtpScreen);
            },text: "Continue",),
            SizedBox(height:45.h,),
            SignInOrSignUp(text: "Sign in",onTap: () {
              context.push(RouteName.signInScreen);
            },),
        
            SizedBox(height: 45.h,),
          ],
        ),
      ),
    );
  }
}
