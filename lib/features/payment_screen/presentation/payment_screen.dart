import 'package:aviation_app/core/constant/padding.dart';
import 'package:aviation_app/core/routes/route_name.dart';
import 'package:aviation_app/core/services/payment_services/stripe_services.dart';
import 'package:aviation_app/core/theme/theme_extension/app_colors.dart';
import 'package:aviation_app/core/utils/common_widget/primary_button/primary_button.dart';
import 'package:aviation_app/features/create_screen/create_screen.dart';
import 'package:aviation_app/features/payment_screen/Riverpod/payment_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:go_router/go_router.dart';

class PaymentScreen extends StatelessWidget {
  const PaymentScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return CreateScreen(
      child: SafeArea(
        child: Padding(
          padding: AppPadding.screenHorizontal,
          child: Column(
            children: [
              SizedBox(height: 24.h),
              Text(
                "Pay to Get Full Access",
                style: Theme.of(context).textTheme.headlineSmall,
              ),
              SizedBox(height: 24.h),
              CardFormField(
                style: CardFormStyle(
                  backgroundColor: Colors.white,
                  textColor: AppColors.primary,
                  borderRadius: 15,
                  borderColor: AppColors.primary,
                  borderWidth: 2,
                  cursorColor: AppColors.primary,
                  placeholderColor: AppColors.primary,
                  textErrorColor: Colors.red,
                ),
              ),
              SizedBox(height: 15.h),
              Consumer(
                builder: (_, ref, _) {
                  final isLoading = ref.watch(paymentProvider).isLoading;
                  return isLoading ?
                  const Center(child: CircularProgressIndicator())
                  :
                  PrimaryButton(
                    bodyText: "Pay",
                    onTap: () async {
                    final success =   await ref.read(paymentProvider.notifier).makePayment();
                    if(success == true && context.mounted){
                      context.go(RouteName.weatherScreen);
                    }
                    },
                  );
                }
              ),
            ],
          ),
        ),
      ),
    );
  }
}
