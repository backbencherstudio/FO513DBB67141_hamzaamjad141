import 'package:aviation_app/core/constant/icons.dart';
import 'package:aviation_app/core/constant/padding.dart';
import 'package:aviation_app/core/routes/route_name.dart';
import 'package:aviation_app/core/utils/common_widget/primary_button/primary_button.dart';
import 'package:aviation_app/features/auth_screens/auth_provider/auth_provider.dart';
import 'package:aviation_app/features/auth_screens/sign_Up%20screen/Riverpod/isVisible_provider.dart';
import 'package:aviation_app/features/auth_screens/sign_in%20screen/presentation/widget/customForgetME_section.dart';
import 'package:aviation_app/features/auth_screens/sign_in%20screen/presentation/widget/custom_textformfiled.dart';
import 'package:aviation_app/features/auth_screens/sign_in%20screen/presentation/widget/richtext.dart';
import 'package:aviation_app/features/create_screen/create_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../sign_Up screen/presentation/widgets/customContainer.dart';
import '../../sign_Up screen/presentation/widgets/or_vector.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({super.key});

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
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
            Consumer(
              builder: (context, ref, _) {
                final isVisible = ref.watch(isLoginVisibleProvider);
                return CustomTextformfiled(
                  text: "Password",
                  isobscure: !isVisible,
                  hintext: "Enter your password",
                  toogleIcon: AppIcons.openEye,
                  icons: AppIcons.eye,
                  isVisible: isVisible,
                  onTapToggle: () {
                    ref.read(isLoginVisibleProvider.notifier).onTapToggle();
                  },
                  controller: passwordController,
                );
              },
            ),
            SizedBox(height: 36.h),
            Padding(
              padding: AppPadding.screenHorizontal,

              child: Consumer(
                builder: (context, ref, _) {
                  final authData = ref.watch(authProvider);

                  return authData.isloading == true
                      ? CircularProgressIndicator()
                      : PrimaryButton(
                          bodyText: "Continue",
                          onTap: () async {
                            final routeName = await ref
                                .read(authProvider.notifier)
                                .loginWithEmailandPassword(
                                  email: emailController.text.trim(),
                                  password: passwordController.text.trim(),
                                );

                            debugPrint(authData.userToken);

                            if (routeName != null && context.mounted) {
                              context.go(RouteName.weatherScreen);
                            } else {
                              if (mounted) {
                                Fluttertoast.showToast(
                                  msg: authData.message.toString(),
                                  backgroundColor: Colors.red,
                                  textColor: Colors.white,
                                );
                              }
                            }
                          },
                        );
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
