import 'package:aviation_app/core/constant/icons.dart';
import 'package:aviation_app/core/constant/padding.dart';
import 'package:aviation_app/core/routes/route_name.dart';
import 'package:aviation_app/core/utils/common_widget/primary_button/primary_button.dart';
import 'package:aviation_app/core/utils/utils.dart';
import 'package:aviation_app/features/auth_screens/auth_provider/auth_provider.dart';
import 'package:aviation_app/features/auth_screens/sign_in%20screen/presentation/widget/custom_textformfiled.dart';
import 'package:aviation_app/features/create_screen/create_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class ResetPassScreen extends StatelessWidget {
  final String email;
  const ResetPassScreen({super.key, required this.email});

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
            Padding(
              padding: AppPadding.screenHorizontal,
              child: Consumer(
                builder: (context, ref, _) {
                  final data = ref.watch(authProvider);
                  return data.isLoading == true
                      ? CircularProgressIndicator()
                      : PrimaryButton(
                          bodyText: "Continue",
                          onTap: () async {
                            if (passwordController.text.trim() !=
                                    confirmPasswordController.text.trim() ||
                                passwordController.text.trim().isEmpty ||
                                confirmPasswordController.text.trim().isEmpty) {
                              Fluttertoast.showToast(
                                msg:
                                    passwordController.text.trim() !=
                                        confirmPasswordController.text.trim()
                                    ? "Passwords do not match!"
                                    : "Please fill all the fields correctly.",
                                backgroundColor: Colors.red,
                                textColor: Colors.white,
                              );
                              return;
                            }

                            final path = await ref
                                .read(authProvider.notifier)
                                .resetpassCall(
                                  email: email,
                                  password: passwordController.text.trim(),
                                );

                            if (path != null && context.mounted) {
                              context.push(path);
                            } else {
                              Fluttertoast.showToast(
                                msg: data.message.toString(),
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
              padding: AppPadding.screenHorizontal,
              child: PrimaryButton(
                onTap: () {},
                bodyText: "Cancel",
                backgroundColor: Color(0xff1D1F2C),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
