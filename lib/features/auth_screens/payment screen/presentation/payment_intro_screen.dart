import 'package:aviation_app/core/constant/padding.dart';
import 'package:aviation_app/features/auth_screens/payment%20screen/presentation/widgets/payment_tile.dart';
import 'package:aviation_app/features/create_screen/create_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class PaymentIntroScreen extends StatelessWidget {
  const PaymentIntroScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final style = Theme.of(context).textTheme;
    return CreateScreen(
      child: Padding(
        padding: AppPadding.screenHorizontal,
        child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
        Text("Pricing",
        style: style.headlineSmall!.copyWith(
        fontWeight: FontWeight.w500,
        ),
        ),
        SizedBox(height: 18.h,),
        Text("Get Unlimited Access\n To All Features",
        textAlign: TextAlign.center,
        style: style.bodyLarge!.copyWith(
        fontSize: 16.sp,
        color: Color(0xffD2D2D5)
        ),
        ),
        SizedBox(height: 24.h,),
        PaymentTile(),
        SizedBox(height: 24.h,),
        Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
        Text("Terms of User",
        style: style.bodySmall!.copyWith(
        fontSize: 14.sp,
        color: Color(0xffD2D2D5)
        ),
        ),
        SizedBox(width: 24.w,),
        Text("Privacy Policy",
        style: style.bodySmall!.copyWith(
        fontSize: 14.sp,
        color: Color(0xffD2D2D5)
        ),
        )
          ],
        )
          ],
             ),
      )
   );
  }
}
