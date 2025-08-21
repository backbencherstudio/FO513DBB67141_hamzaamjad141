import 'package:aviation_app/core/constant/icons.dart';
import 'package:aviation_app/core/constant/images.dart';
import 'package:aviation_app/core/utils/utils.dart';
import 'package:aviation_app/features/payment_screen/presentation/widgets/subscription_cancel_dialog.dart';
import 'package:aviation_app/features/payment_screen/Riverpod/payment_provider.dart';
import 'package:aviation_app/features/splash/splash_provider/isfreetrailProvider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

import '../../../auth_screens/auth_provider/auth_provider.dart';
import '../payment_screen.dart';

class PaymentTile extends ConsumerStatefulWidget {
  const PaymentTile({super.key});

  @override
  ConsumerState<PaymentTile> createState() => _PaymentTileState();
}

class _PaymentTileState extends ConsumerState<PaymentTile> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      ref.read(isfreetrailProvider.notifier).checkFreeTrialStatus();
    });
  }


  @override
  Widget build(BuildContext context) {
    final style = Theme.of(context).textTheme;
    return Stack(
      children: [
        Opacity(
          opacity: 0.5,
          child: Image.asset(AppImages.priceBg, width: 330.w),
        ),
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
              SizedBox(height: 6.h),
              Consumer(
                builder: (context, ref, child) {
                  final user = ref.watch(authProvider).user;
                  final isPremium = user?.premium ?? false;

                  final isfreetrailOn = ref
                      .watch(isfreetrailProvider)
                      .hasRealSubscription;

                      
                  debugPrint("Premium status: $isfreetrailOn");
                  debugPrint("User data: ${user?.toJson()}");

                  return isfreetrailOn == false
                      ? Column(
                          children: [
                            SizedBox(height: 30.h),
                            Consumer(
                              builder: (_, ref, _) {
                                final bool isLoading = ref
                                    .watch(paymentProvider)
                                    .isWebPageButtonLoading;
                                return Utils.primaryButton(
                                  isLoading: isLoading,
                                  onPressed: () async {
                                    final url = await ref
                                        .read(paymentProvider.notifier)
                                        .makePayment();
                                    debugPrint("Payment URL: $url");
                                    if (url != null) {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) =>
                                              PaymentWebView(paymentUrl: url),
                                        ),
                                      );
                                    }
                                  },
                                  text: "Get Full Access",
                                  height: 54.h,
                                  width: 280.w,
                                );
                              },
                            ),
                          ],
                        ): Column(
                          children: [
                            Center(
                              child: Text(
                                "You already have this plan",
                                style: style.bodyLarge!.copyWith(
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
                            SizedBox(height: 30.h),
                            Utils.primaryButton(
                              onPressed: () {
                                showDialog(
                                  context: context,
                                  builder: (BuildContext context) {
                                    return SubscriptionCancelDialog();
                                  },
                                );
                              },
                              backgroundColor: Colors.redAccent,
                              text: "Cancel Subscription",
                              height: 54.h,
                              width: 280.w,
                            ),
                          ],
                        );
                      
                },
              ),
            ],
          ),
        ),
      ],
    );
  }
}
