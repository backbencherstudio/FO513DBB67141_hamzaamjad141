// import 'dart:convert';

// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:flutter_stripe/flutter_stripe.dart';
// import 'package:fluttertoast/fluttertoast.dart';
// import 'package:http/http.dart' as http;

// class StripeServices {
//   StripeServices._();
//   static final StripeServices instance = StripeServices._();

//   final String publishableKey =
//       "pk_test_51R7YCuFKXEtfT5CGd9p48VbqDaf5azpaHB4rada6f7AzL7eTXG00GNPsRcPOQDdyLTduywLmHc9cUSm3QkAwzXa400zTadXSnn";

//   Future<void> initialize() async {
//     Stripe.publishableKey = publishableKey;
//     await Stripe.instance.applySettings();
//   }

//   Future<String?> createPaymentMethod() async {
//     try {
//       final paymentMethod = await Stripe.instance.createPaymentMethod(
//         params: PaymentMethodParams.card(
//           paymentMethodData: PaymentMethodData(
//             billingDetails: BillingDetails(email: 'shakinhabib2000@gmail.com'),
//           ),
//         ),
//       );
//       debugPrint("\npayment method id : ${paymentMethod.id}\n");
//       return paymentMethod.id;
//     } catch (e) {
//       Fluttertoast.showToast(
//         msg: "Failed to create payment method",
//         backgroundColor: Colors.red,
//         fontSize: 14.sp,
//       );
//       throw Exception('\nFailed to create payment method: $e\n');
//     }
//   }
// }
