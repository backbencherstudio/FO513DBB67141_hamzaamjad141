import 'package:aviation_app/core/constant/icons.dart';
import 'package:aviation_app/core/constant/padding.dart';
import 'package:aviation_app/core/routes/route_name.dart';
import 'package:aviation_app/core/utils/common_widget/primary_button/primary_button.dart';
import 'package:aviation_app/features/auth_screens/auth_provider/auth_provider.dart';
import 'package:aviation_app/features/auth_screens/sign_in%20screen/presentation/widget/custom_textformfiled.dart';
import 'package:aviation_app/features/auth_screens/sign_in%20screen/presentation/widget/richtext.dart';
import 'package:aviation_app/features/create_screen/create_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class ForgetPasScreen extends StatelessWidget {
  const ForgetPasScreen({super.key});

  @override
  Widget build(BuildContext context) {
    TextEditingController emailController = TextEditingController();
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
              "Forget Password",
              style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                fontSize: 32.sp,
                fontWeight: FontWeight.w100,
              ),
            ),
            Text(
              "Enter your email account to reset password",
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.titleSmall!.copyWith(
                fontSize: 18.sp,
                fontWeight: FontWeight.w400,
                color: Color(0xffA5A5AB),
              ),
            ),
            SizedBox(height: 48.h),
            CustomTextformfiled(
              hintext: "Enter your email",
              text: "Email",
              icons: AppIcons.message,
              controller: emailController,
            ),
            SizedBox(height: 36.h),
            Padding(
              padding: AppPadding.screenHorizontal,
              child: Consumer(
                builder: (context, ref, _) {
                  final otpStatus = ref.watch(authProvider);

                  return otpStatus.isLoading == true
                      ? CircularProgressIndicator()
                      : PrimaryButton(
                          bodyText: "Continue",
                          onTap: () async {
                            final path = await ref
                                .read(authProvider.notifier)
                                .sendOtp(email: emailController.text.trim());

                            if (path != null && context.mounted) {
                              context.push(path);
                            }else{
                              Fluttertoast.showToast(
                                  msg: otpStatus.message.toString(),
                                  backgroundColor: Colors.red,
                                  textColor: Colors.white,
                                );
                            }
                          },
                        );
                },
              ),
            ),
            SizedBox(height: 16.h),

            Padding(
              padding: EdgeInsetsGeometry.only(left: 24.w, right: 24.w),
              child: PrimaryButton(
                onTap: () {
                  context.push(RouteName.signInScreen);
                },
                bodyText: "Cancel",
                backgroundColor: Color(0xff1D1F2C),
              ),
            ),
            SizedBox(height: 64.h),
            SignInOrSignUp(
              text: 'Sign up',
              onTap: () {
                context.push(RouteName.signupScreen);
              },
            ),
          ],
        ),
      ),
    );
  }
}
