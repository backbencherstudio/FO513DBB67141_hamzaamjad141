import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;

class StripeServices {
  StripeServices._();
  static final StripeServices instance = StripeServices._();

  final String publishableKey =
      "pk_test_51QuTWKClJBhr3sfisvZF8NprucrbSftJa16ma4XVStJG04nQ5i4tNL00XkBbfC0UFzY8AvnFhzt8wTk1CbXj57o500ncgA4fQl";

  Future<void> initialize() async {
    try{
      Stripe.publishableKey = publishableKey;
      await Stripe.instance.applySettings();
      //debugPrint('\n successfully initialize stripe\n');
      //Stripe.instance.setLogLevel(LogLevel.debug);
    }catch(e){
      throw Exception(e);
    }
  }

  Future<String?> createPaymentMethod({required String email}) async {
    try {
      final paymentMethod = await Stripe.instance.createPaymentMethod(
        params: PaymentMethodParams.card(
          paymentMethodData: PaymentMethodData(
            billingDetails: BillingDetails(email: email),
          ),
        ),
      );
      debugPrint("\npayment method id : ${paymentMethod.id}\n");
      return paymentMethod.id;
    } catch (e) {
      Fluttertoast.showToast(
        msg: "Failed to create payment method",
        backgroundColor: Colors.red,
        fontSize: 14.sp,
      );
      throw Exception('\nFailed to create payment method: $e\n');
    }
  }
}
