import 'package:aviation_app/features/auth_screens/auth_provider/auth_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/routes/route_name.dart';
import '../../../core/services/local_storage_services/shared_preferences_services/sharedPref_service.dart';
import '../../../core/services/local_storage_services/shared_preferences_services/shared_preferences_key_name.dart';


class SplashState{}

final splashProvider = StateNotifierProvider<SplashProvider, SplashState>((ref){
  final authNotifier = ref.read(authProvider.notifier);
  return SplashProvider(authNotifier);});

class SplashProvider extends StateNotifier<SplashState>{
  final AuthProvider authNotifier;
  SplashProvider(this.authNotifier):super(SplashState());
   Future<String> handleAppOpeningCount() async {
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
        final bool success = await authNotifier.initializeUser(userToken: userToken);
        if(success){
          return RouteName.weatherScreen;
        }
      }
      debugPrint("\nuser token : is null,\n returning to sign in screen...\n");
      return RouteName.signInScreen;
    }
  }
}