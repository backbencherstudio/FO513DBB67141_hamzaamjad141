import 'package:flutter/material.dart';
import '../../../core/routes/route_name.dart';
import '../../../core/services/local_storage_services/shared_preferences_services/sharedPref_service.dart';
import '../../../core/services/local_storage_services/shared_preferences_services/shared_preferences_key_name.dart';

class SplashProvider{
  static Future<String> handleAppOpeningCount() async {
    final openingCount = await SharedPreferenceStorageService.getInt(key: SharedPreferencesKeyName.openingCount);
    if(openingCount == null){
      await SharedPreferenceStorageService.saveInt(key: SharedPreferencesKeyName.openingCount, value: 1);
      debugPrint("\nFirst Time App Open.\n");
      return RouteName.onboardingScreen;
    }
    else{
      await SharedPreferenceStorageService.saveInt(key: SharedPreferencesKeyName.openingCount, value: openingCount+1);
      debugPrint("\nApp Opening time : $openingCount\n");
      final userToken = await SharedPreferenceStorageService.getString(key: SharedPreferencesKeyName.userToken);
      if(userToken != null){
        debugPrint("\nuser token : $userToken,\n returning to weather screen...\n");
        return RouteName.weatherScreen;
      }
      debugPrint("\nuser token : is null,\n returning to sign in screen...\n");
      return RouteName.signInScreen;
    }
  }
}