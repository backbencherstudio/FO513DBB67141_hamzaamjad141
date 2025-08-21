import 'package:aviation_app/core/constant/icons.dart';
import 'package:aviation_app/core/constant/padding.dart';
import 'package:aviation_app/core/routes/route_name.dart';
import 'package:aviation_app/core/utils/common_widget/primary_button/primary_button.dart';
import 'package:aviation_app/features/auth_screens/auth_provider/auth_provider.dart';
import 'package:aviation_app/features/auth_screens/sign_Up%20screen/Riverpod/isVisible_provider.dart';
import 'package:aviation_app/features/auth_screens/sign_Up%20screen/presentation/widgets/customAnimatedContainer.dart';
import 'package:aviation_app/features/auth_screens/sign_in%20screen/presentation/widget/custom_textformfiled.dart';
import 'package:aviation_app/features/auth_screens/sign_in%20screen/presentation/widget/richtext.dart';
import 'package:aviation_app/features/create_screen/create_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {

  late final TextEditingController nameController;
  late final TextEditingController licenseController;
  late final TextEditingController emailController;
  late final TextEditingController passwordController;
  late final TextEditingController confirmPasswordController;


  @override
  void initState() {
    nameController = TextEditingController();
    licenseController = TextEditingController(text: "NO_LICENCE");
    emailController = TextEditingController();
    passwordController = TextEditingController();
    confirmPasswordController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    nameController.dispose();
    licenseController.dispose();
    emailController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
    super.dispose();
  }

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
            CustomTextformfiled(
              text: "Name",
              hintext: "Enter your name",
              icons: AppIcons.user,
              controller: nameController,
            ),
            SizedBox(height: 18.h),
            CustomTextformfiled(
              text: "Email",
              hintext: "Enter your email",
              icons: AppIcons.message,
              controller: emailController,
            ),
            SizedBox(height: 18.h),
            CustomAnimatedContainer(
              icons: AppIcons.dropdown,
              controller: licenseController,
              dropdownItems: ["NO_LICENCE", "SPL", "PPL", "CPL1", "ATPL", "CH"],
            ),
            SizedBox(height: 18.h),
            Consumer(
              builder: (context, ref,_) {
             final isVisible = ref.watch(isPassVisibleProvider);
                return CustomTextformfiled(
                  isVisible: isVisible,
                  onTapToggle: () {
                    ref.read(isPassVisibleProvider.notifier).onTapToggle();
                  },
                  text: "Password",
                  isobscure: !isVisible,
                  hintext: "Enter your password",
                  icons: AppIcons.eye,
                  toogleIcon: AppIcons.openEye,
                  controller: passwordController,
                );
              }
            ),
            SizedBox(height: 18.h),
            Consumer(
              builder: (context, ref, _) {
                final isVisible = ref.watch(isConfirmPAssVisibleProvider);
                return CustomTextformfiled(
                  isVisible: isVisible,
                  onTapToggle: () {
                   ref.read(isConfirmPAssVisibleProvider.notifier).onTapToggle();

                  },
                  text: "Confirm Password",
                  isobscure: !isVisible,
                  hintext: "Enter your password",
                  icons: AppIcons.eye,
                  toogleIcon: AppIcons.openEye,
                  controller: confirmPasswordController,
                );
              }
            ),
            SizedBox(height: 36.h),
            Padding(
              padding: AppPadding.screenHorizontal,
              child: Consumer(
                builder: (context, ref, _) {
                  final signUpData = ref.watch(authProvider);
                  return signUpData.isLoading == true
                      ? CircularProgressIndicator()
                      : PrimaryButton(
                          bodyText: "Continue",
                          onTap: () async {
                            if (emailController.text.isEmpty ||
                                nameController.text.isEmpty ||
                                licenseController.text.isEmpty ||
                                passwordController.text.trim() !=
                                    confirmPasswordController.text.trim()) {
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

                            final routeName = await ref
                                .read(authProvider.notifier)
                                .signUpWithCredentials(
                                  name: nameController.text.trim(),
                                  email: emailController.text.trim(),
                                  license: licenseController.text.trim(),
                                  password: passwordController.text.trim(),
                                );
                            if (routeName != null && context.mounted) {
                          context.push(routeName);

                            } else {
                              Fluttertoast.showToast(
                                msg: "Sign-up failed. Please try again.",
                                backgroundColor: Colors.red,
                                textColor: Colors.white,
                              );
                            }
                          },
                        );
                },
              ),
            ),
            SizedBox(height: 45.h),
            SignInOrSignUp(
              text: "Sign in",
              onTap: () {
                context.push(RouteName.signInScreen);
              },
            ),

            SizedBox(height: 45.h),
          ],
        ),
      ),
    );
  }
}
