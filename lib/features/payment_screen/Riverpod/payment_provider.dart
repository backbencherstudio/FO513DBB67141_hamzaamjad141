import 'package:aviation_app/core/services/api_services/api_endpoints.dart';
import 'package:aviation_app/core/services/api_services/api_services.dart';
import 'package:aviation_app/features/auth_screens/auth_provider/auth_provider.dart';
import 'package:aviation_app/features/payment_screen/Riverpod/payment_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../../../core/services/payment_services/stripe_services.dart';

final selectionProvider = StateProvider<String?>((ref) {
  return null;
});

final paymentProvider = StateNotifierProvider<PaymentProvider, PaymentState>((
  ref,
) {
  final userToken = ref.watch(authProvider).userToken ?? "";
  final userEmail = ref.watch(authProvider).user?.email ?? "";
  return PaymentProvider(userToken: userToken, userEmail: userEmail);
});

class PaymentProvider extends StateNotifier<PaymentState> {
  final String userToken;
  final String userEmail;
  PaymentProvider({required this.userToken, required this.userEmail}) : super(PaymentState());
  Future<String?> makePayment() async {
    try {
    //  state = state.copyWith(isLoading: true);
    //  final paymentId = await StripeServices.instance.createPaymentMethod(email: userEmail);
    //  final body = {"paymentMethodId": paymentId};
      final headers = {
        "Authorization": userToken,
        "Content-Type": "application/json",
      };
      final response = await ApiServices.instance.postData(
        endPoint: ApiEndPoints.paymentWebPage,
        body: {},
        headers: headers,
      );
      if (response["success"]) {

        // Fluttertoast.showToast(
        //   msg: "Payment Successful",
        //   backgroundColor: Colors.green,
        //   textColor: Colors.white,
        // );
      //  state = state.copyWith(isLoading: false);
        debugPrint("\npayment url : ${response['checkoutUrl']}\n");
        return response['checkoutUrl'];
      } else {
        Fluttertoast.showToast(
          msg: response["message"],
          backgroundColor: Colors.red,
          textColor: Colors.white,
        );
       // state = state.copyWith(isLoading: false);
        return 'false';
      }

    } catch (error) {
      state = state.copyWith(isLoading: false);
      throw Exception("Failed to make payment : $error");
    }
  }
  
  
  Future<bool?> onPromoCodeSubmit({required String promoCode}) async {
    try{
      state = state.copyWith(isLoading: true);
      final response = await ApiServices.instance.postData(
          endPoint: ApiEndPoints.promoCode,
          body: {
            "promoCode" : promoCode
          },
          headers: {
            "Authorization" : userToken,
            "Content-Type" : "application/json"
          }
      );
      state = state.copyWith(isLoading: false);
      if(response['success']){
        Fluttertoast.showToast(
          msg: "Promo Code Applied",
          backgroundColor: Colors.green,
          textColor: Colors.white,
        );

        return true;
      }else{
        Fluttertoast.showToast(
          msg: response['message'],
          backgroundColor: Colors.red,
          textColor: Colors.white,
        );

      }
      return false;
    }catch(error){
      state = state.copyWith(isLoading: false);
      throw Exception('Failed to submit promo code : $error');
    }
  }
}
