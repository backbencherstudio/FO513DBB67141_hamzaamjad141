import 'package:aviation_app/core/constant/icons.dart';
import 'package:aviation_app/core/constant/images.dart';
import 'package:aviation_app/core/routes/route_name.dart';
import 'package:aviation_app/core/utils/utils.dart';
import 'package:aviation_app/features/payment_screen/Riverpod/payment_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';

import '../payment_screen.dart';

class PaymentTile extends StatelessWidget {
  const PaymentTile({super.key});

  @override
  Widget build(BuildContext context) {
    final style = Theme.of(context).textTheme;
    return Stack(
      children: [
        Opacity(opacity: 0.5, child: Image.asset(AppImages.priceBg)),
        Positioned(
          top: 32.h,
          left: 24.w,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Pro",
                style: style.headlineSmall!.copyWith(
                  fontWeight: FontWeight.w500,
                ),
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "\$9.99",
                    style: style.headlineLarge!.copyWith(fontSize: 40.sp),
                  ),
                  SizedBox(width: 4.w),
                  Text(
                    "/month",
                    style: style.titleSmall!.copyWith(
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 32.h),
              Text(
                "Includes:",
                style: style.bodyLarge!.copyWith(fontWeight: FontWeight.w500),
              ),
              SizedBox(height: 18.h),
              Row(
                children: [
                  SvgPicture.asset(AppIcons.tick),
                  SizedBox(width: 5.w),
                  Text(
                    "Aviation weather",
                    style: style.bodyLarge!.copyWith(
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w400,
                      color: Color(0xff777980),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 6.h),
              Row(
                children: [
                  SvgPicture.asset(AppIcons.tick),
                  SizedBox(width: 5.w),
                  Text(
                    "Pilot Logbook",
                    style: style.bodyLarge!.copyWith(
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w400,
                      color: Color(0xff777980),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 6.h),
              Row(
                children: [
                  SvgPicture.asset(AppIcons.tick),
                  SizedBox(width: 5.w),
                  Text(
                    "Pilots AI voice assistant",
                    style: style.bodyLarge!.copyWith(
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w400,
                      color: Color(0xff777980),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 6.h),
              Row(
                children: [
                  SvgPicture.asset(AppIcons.tick),
                  SizedBox(width: 5.w),
                  Text(
                    "Podcasts",
                    style: style.bodyLarge!.copyWith(
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w400,
                      color: Color(0xff777980),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 6.h),
              Row(
                children: [
                  SvgPicture.asset(AppIcons.tick),
                  SizedBox(width: 5.w),
                  Text(
                    "E books",
                    style: style.bodyLarge!.copyWith(
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w400,
                      color: Color(0xff777980),
                    ),
                  ),
                ],
              ),

              SizedBox(height: 30.h),
              Consumer(
                builder: (_, ref, _) {
                  return Utils.primaryButton(
                    onPressed: ()  async {
                      final url = await ref.read(paymentProvider.notifier).makePayment();
                      debugPrint("\nurl in screen : $url\n");
                      Navigator.push(context, MaterialPageRoute(builder: (context)=>PaymentWebView(paymentUrl: url!,)));

                      //   context.push(RouteName.payment);
                    },
                    text: "Get Full Access",
                    height: 54.h,
                    width: 280.w,
                  );
                }
              ),
            ],
          ),
        ),
      ],
    );
  }
}
