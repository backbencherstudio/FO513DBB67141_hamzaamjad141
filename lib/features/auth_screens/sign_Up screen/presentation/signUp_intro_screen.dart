import 'package:aviation_app/core/constant/icons.dart';
import 'package:aviation_app/core/routes/route_name.dart';
import 'package:aviation_app/features/auth_screens/sign_Up%20screen/presentation/widgets/customContainer.dart';
import 'package:aviation_app/features/auth_screens/sign_Up%20screen/presentation/widgets/or_vector.dart';
import 'package:aviation_app/features/auth_screens/sign_in%20screen/presentation/widget/custom_dummy_button.dart';
import 'package:aviation_app/features/auth_screens/sign_in%20screen/presentation/widget/richtext.dart';
import 'package:aviation_app/features/create_screen/create_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

class SignupIntroScreen extends StatelessWidget {
  const SignupIntroScreen({super.key});

  @override
  Widget build(BuildContext context) {
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
              "Ready for Takeoff?",
              style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                fontSize: 32.sp,
                fontWeight: FontWeight.w100,
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Let’s Set ",
                  style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                    fontSize: 32.sp,
                    fontWeight: FontWeight.w100,
                    color: Color(0xff3762E4),
                  ),
                ),

                Text(
                  "You Up",
                  style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                    fontSize: 32.sp,
                    fontWeight: FontWeight.w100,
                  ),
                ),
              ],
            ),
            SizedBox(height: 48.h),

            CustomDummyButton(
              onTap: () {
                context.go(RouteName.signupScreen);
              },
              text: "Continue",
            ),

            SizedBox(height: 36.h),
            OrVector(),
            SizedBox(height: 24.h,),
            Customcontainer(text: 'Continue With Google', img: AppIcons.google),
            SizedBox(height: 16.h),
            Customcontainer(
              text: 'Continue With Facebook',
              img: AppIcons.facebook,
            ),
            SizedBox(height: 64.h),
            SignInOrSignUp(
              text: 'Sign in',
              onTap: () {
                context.push(RouteName.signInScreen);
              },
            ),
          ],
        ),
      ),
    );
  }
}
