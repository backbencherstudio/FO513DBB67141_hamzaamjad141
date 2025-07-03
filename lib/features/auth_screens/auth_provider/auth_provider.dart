import 'package:aviation_app/core/routes/route_name.dart';
import 'package:aviation_app/core/services/api_services/api_endpoints.dart';
import 'package:aviation_app/core/services/api_services/api_services.dart';
import 'package:aviation_app/core/services/local_storage_services/shared_preferences_services/sharedPref_service.dart';
import 'package:aviation_app/core/services/local_storage_services/shared_preferences_services/shared_preferences_key_name.dart';
import 'package:aviation_app/features/auth_screens/auth_provider/auth_state.dart';
import 'package:aviation_app/features/auth_screens/model/user_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/services/google_account_services/google_account_service.dart';

final authProvider = StateNotifierProvider<AuthProvider, AuthState>((ref) {
  return AuthProvider();
});

class AuthProvider extends StateNotifier<AuthState> {
  AuthProvider() : super(AuthState());

  Future<String> createAccountWithGoogle() async {
    try {
      final googleUserModel = await GoogleAccountService().signInWithGoogle();
      if (googleUserModel != null) {
        final body = {
          "name": googleUserModel.fullName,
          "email": googleUserModel.email,
          "image": googleUserModel.photoUrl,
        };
        final headers = {"Content-Type": "Application/json"};
        final response = await ApiServices.instance.postData(
          endPoint: ApiEndPoints.googleLogin,
          body: body,
          headers: headers,
        );
        debugPrint("\nResponse : $response\n");
       // final UserModel user = UserModel.fromJson(response['user']);
      final userToken = response['token'];
        await SharedPreferenceStorageService.saveString(
          SharedPreferencesKeyName.userToken,
          userToken ?? "",
        );
        state = state.copyWith(
          googleUser: googleUserModel,
         // user: user,
        //  userToken: userToken,
        );
       debugPrint("\nuser token : $userToken.\n");
        return RouteName.weatherScreen;
      }
      return RouteName.signInScreen;
    } catch (error) {
      throw Exception(
        '\nException while creating account with google : $error\n',
      );
    }
  }
}
