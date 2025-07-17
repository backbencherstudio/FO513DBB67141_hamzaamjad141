import 'package:aviation_app/core/routes/route_name.dart';
import 'package:aviation_app/core/utils/common_widget/primary_button/primary_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/constant/icons.dart';
import '../../../auth_screens/sign_in screen/presentation/widget/custom_textformfiled.dart';
import '../../Riverpod/payment_provider.dart';

class PromoCodeSubmitForm extends StatefulWidget {
  const PromoCodeSubmitForm({super.key});

  @override
  State<PromoCodeSubmitForm> createState() => _PromoCodeSubmitFormState();
}

class _PromoCodeSubmitFormState extends State<PromoCodeSubmitForm> {
  late final TextEditingController promoCodeController;
  late final FocusNode focusNode;

  @override
  void initState() {
    promoCodeController = TextEditingController();
    focusNode = FocusNode();
    super.initState();
  }

  @override
  void dispose() {
    promoCodeController.dispose();
    focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      spacing: 12.h,
      children: [
        CustomTextformfiled(
          text: "Promo Code",
          hintext: "Enter Promo Code",
          controller: promoCodeController,
          focusNode: focusNode,
        ),
        Consumer(
          builder: (_, ref, _) {
            final isLoading = ref.watch(paymentProvider).isLoading;
            return isLoading ?
            const Center(child: CircularProgressIndicator(),)
            :
            PrimaryButton(
              bodyText: "Continue",
              onTap: () async  {
                if (promoCodeController.text.isEmpty) {
                  Fluttertoast.showToast(
                    msg: "Please enter promo code!",
                    backgroundColor: Colors.red,
                    textColor: Colors.white,
                    gravity: ToastGravity.TOP,
                  );
                } else {
                  final success = await ref.read(paymentProvider.notifier).onPromoCodeSubmit(promoCode: promoCodeController.text);
                if(success == true && context.mounted){
                  context.go(RouteName.weatherScreen);
                }
                }
              },
            );
          }
        ),
      ],
    );
  }
}
