

import 'package:aviation_app/core/services/api_services/api_endpoints.dart';
import 'package:aviation_app/core/services/api_services/api_services.dart';
import 'package:aviation_app/core/services/local_storage_services/shared_preferences_services/sharedPref_service.dart';
import 'package:aviation_app/core/services/local_storage_services/shared_preferences_services/shared_preferences_key_name.dart';
import 'package:aviation_app/features/splash/splash_provider/freetrail_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final isfreetrailProvider = StateNotifierProvider<IsFreeTrailNotifier, trailState>(
  (ref) => IsFreeTrailNotifier(),
);

class IsFreeTrailNotifier extends StateNotifier<trailState> {
  IsFreeTrailNotifier() : super(trailState());

  Future<void> checkFreeTrialStatus() async {

   debugPrint("Free trial starts");

    state = state.copyWith(isloading: true);
    try {



 final userToken = await SharedPreferenceStorageService.getString(key: SharedPreferencesKeyName.userToken);

final headers = {
      'Authorization': '$userToken',
      'Content-Type': 'application/json',
    };
     final response  = await ApiServices.instance.getData(endPoint: ApiEndPoints.isfreetrail , headers: headers);
     
     debugPrint("Free trial starts ${response.toString()}");
     

      if (response != null && response['success'] == true) {
        final hasRealSubscription = response['data']['hasRealSubscription'];

        debugPrint("Free trial status: $hasRealSubscription");
       
       
        state = state.copyWith(
          isSuccess: response['status'],
          message: response['message'],
          hasRealSubscription: response['data']['hasRealSubscription'],
          isloading: false,
        );
               // debugPrint("Free trial starts");

        debugPrint("\n\n${response.toString()}\n\n");
        debugPrint("Free trial status: $hasRealSubscription");
      } else {
        state = state.copyWith(
          isSuccess: 'error',
          message: 'Failed to check free trial status',
          isloading: false,
        );
      }
    
    
    } catch (e) {
     throw Exception('Error checking free trial status: $e');
      
    }
  }
}