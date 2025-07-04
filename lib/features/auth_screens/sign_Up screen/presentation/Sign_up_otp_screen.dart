import 'package:aviation_app/core/constant/padding.dart';
import 'package:aviation_app/core/routes/route_name.dart';
import 'package:aviation_app/core/theme/theme_extension/app_colors.dart';
import 'package:aviation_app/core/utils/common_widget/primary_button/primary_button.dart';
import 'package:aviation_app/core/utils/utils.dart';
import 'package:aviation_app/features/auth_screens/auth_provider/auth_provider.dart';
import 'package:aviation_app/features/auth_screens/sign_in%20screen/presentation/widget/resendtext.dart';
import 'package:aviation_app/features/create_screen/create_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

class SignUpOtpScreen extends StatelessWidget {
  final String email;
  const SignUpOtpScreen({super.key, required this.email});

  @override
  Widget build(BuildContext context) {
    TextEditingController otpController = TextEditingController();
    return CreateScreen(
      child: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(height: 100.h),
            Text(
              "LEFT SEAT LESSONS",
              style: Theme.of(context).textTheme.headlineSmall,
            ),
            SizedBox(height: 80.h),
            Text(
              "Enter Verification Code",
              style: Theme.of(
                context,
              ).textTheme.headlineSmall!.copyWith(fontWeight: FontWeight.w500),
            ),
            Text(
              "We have sent a code to ",
              style: Theme.of(context).textTheme.titleSmall!.copyWith(
                fontWeight: FontWeight.w400,
                color: Color(0xffA5A5AB),
              ),
            ),
            Text(
              "enamulhaque@gmail.com",
              style: Theme.of(context).textTheme.titleSmall!.copyWith(
                fontWeight: FontWeight.w400,
                color: Color(0xffffffff),
              ),
            ),
            SizedBox(height: 48.h),
            PinCodeTextField(
              controller: otpController,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              appContext: context,
              length: 4,
              hintCharacter: '●',
              obscureText: false,
              animationType: AnimationType.fade,
              pinTheme: PinTheme(
                shape: PinCodeFieldShape.box,
                borderRadius: BorderRadius.circular(12.r),
                fieldHeight: 58.h,
                fieldWidth: 67.w,
                activeFillColor: Colors.transparent,
                inactiveFillColor: Colors.transparent,
                inactiveColor: Color(0xff4A4C56),
                activeColor: Color(0xff3762E4),
                selectedColor: AppColors.secondary,
              ),
              animationDuration: Duration(milliseconds: 300),
              backgroundColor: Colors.transparent,
            ),
            SizedBox(height: 36.h),
            Padding(
              padding: AppPadding.screenHorizontal,
              child: Consumer(
                builder: (context, ref, _) {
                  final auth = ref.watch(authProvider);
                  return auth.isloading == true
                      ? CircularProgressIndicator()
                      : PrimaryButton(
                          bodyText: "Verify Now",
                          onTap: () async {
                            debugPrint(email);
                            final path = await ref
                                .read(authProvider.notifier)
                                .signUpOtpVerification(
                                  email: email,
                                  otp: otpController.text.trim(),
                                );
                            if (path != null && context.mounted) {
                              context.push(path);
                            }else {
                              Fluttertoast.showToast(
                                msg: "${auth.message} Please try again.",
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
            Resendtext(),
          ],
        ),
      ),
    );
  }
}
