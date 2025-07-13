import 'package:aviation_app/core/constant/padding.dart';
import 'package:aviation_app/core/routes/route_name.dart';
import 'package:aviation_app/features/create_screen/create_screen.dart';
import 'package:aviation_app/features/payment_screen/presentation/widgets/payment_tile.dart';
import 'package:aviation_app/features/payment_screen/presentation/widgets/promo_code_submit_form.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

class PaymentIntroScreen extends StatelessWidget {
  const PaymentIntroScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final style = Theme.of(context).textTheme;
    return CreateScreen(
      child: Padding(
        padding: AppPadding.screenHorizontal,
        child: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 10.h),
                Text(
                  "Promo Code",
                  style: style.headlineSmall,
                ),
                SizedBox(height: 18.h),
                Text(
                  "Get Unlimited Access To All Features",
                  textAlign: TextAlign.center,
                  style: style.bodyLarge!.copyWith(
                    fontSize: 16.sp,
                    color: Color(0xffD2D2D5),
                  ),
                ),
                SizedBox(height: 18.h),
                /// ====== Promo Code ====== ///
                PromoCodeSubmitForm(),
                /// ====== Promo Code ====== ///
                SizedBox(height: 22.h),
                PaymentTile(),
                SizedBox(height: 24.h),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    GestureDetector(
                      onTap: ()=>context.push(RouteName.privacyPolicyScreen),
                      child: Text(
                        "Privacy Policy",
                        style: style.bodySmall!.copyWith(
                          fontSize: 14.sp,
                          color: Color(0xffD2D2D5),
                          decoration: TextDecoration.underline,
                          decorationColor: Color(0xffD2D2D5),
                        ),
                      ),
                    ),

                    GestureDetector(
                      onTap: ()=>context.push(RouteName.privacyPolicyScreen),

                      child: Text(
                        "Terms & Conditions",
                        style: style.bodySmall!.copyWith(
                          fontSize: 14.sp,
                          color: Color(0xffD2D2D5),
                          decoration: TextDecoration.underline,
                          decorationColor: Color(0xffD2D2D5),
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 30.h),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
