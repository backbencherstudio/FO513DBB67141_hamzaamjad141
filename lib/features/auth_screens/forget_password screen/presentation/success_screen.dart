import 'package:aviation_app/core/constant/images.dart';
import 'package:aviation_app/core/constant/padding.dart';
import 'package:aviation_app/core/routes/route_name.dart';
import 'package:aviation_app/core/utils/utils.dart';
import 'package:aviation_app/features/auth_screens/sign_in%20screen/presentation/widget/custom_dummy_button.dart';
import 'package:aviation_app/features/create_screen/create_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

class SuccessScreen extends StatelessWidget {
  const SuccessScreen({super.key});

  @override
  Widget build(BuildContext context) {
     return CreateScreen(
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(height: 160.h),
            Text(
              "Successful",
              style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                fontSize: 32.sp,
                fontWeight: FontWeight.w100,
              ),
            ),
            Padding(
              padding: AppPadding.screenHorizontal,
              child: Text(
                "Your password was successfully changed",
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.titleSmall!.copyWith(
                  fontWeight: FontWeight.w400,
                  fontSize: 18.sp,
                  color: Color(0xffA5A5AB),
                ),
              ),
            ),
            SizedBox(height: 48.h),
            Image.asset(AppImages.successLogo, height: 255.h, width: 255.w),
            SizedBox(height: 40.h,),
             Padding(
              padding: AppPadding.screenHorizontal,
              child: Utils.primaryButton(text: "Continue", 
              height: 54.h,
              onPressed: () {context.push(RouteName.signInScreen);}),
            ),
          ],
        ),
      ),
    );
  }
}
