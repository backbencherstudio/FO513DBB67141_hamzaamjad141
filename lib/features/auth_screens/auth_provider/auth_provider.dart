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
         final UserModel user = UserModel.fromJson(response['user']);
        final userToken = response['token'];
        await SharedPreferenceStorageService.saveString(
          SharedPreferencesKeyName.userToken,
          userToken ?? "",
        );
        state = state.copyWith(
          googleUser: googleUserModel,
           user: user,
            userToken: userToken,
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

  //sign up code

  Future<String?> loginWithEmailAndPassword({
    required String email,
    required String password,
  }) async {
    state = state.copyWith(isLoading: true);

    try {
      final payload = {"email": email, "password": password};
      debugPrint(payload.toString());
      final response = await ApiServices.instance.postData(
        endPoint: ApiEndPoints.login,
        body: payload,
        headers: {'Content-Type': 'application/json'},
      );
      debugPrint("\n\n $response \n\n ");
      final success = response['success'].toString().toLowerCase() == "true";
      if (success) {
        final token = response["token"];
        final userJson = response["user"];
        if (token != null) {
          await SharedPreferenceStorageService.saveString(
            SharedPreferencesKeyName.userToken,
            token,
          );
        }
        state = state.copyWith(
          isLoading: false,
          userToken: token,
          user: UserModel.fromJson(userJson),
        );
        debugPrint("Login successful. User ID: ${state.user?.id}");

        return RouteName.weatherScreen;
      } else {
        state = state.copyWith(isLoading: false);

        return null;
      }
    } catch (e) {
      state = state.copyWith(isLoading: false);

      throw Exception(e);
    }
  }

  /// register with email,pass,spl,
  Future<String?> signUpWithCredentials({
    required String name,
    required String email,
    required String license,
    required String password,
  }) async {
    state = state.copyWith(isLoading: true);
    try {
      final payload = {
        "name": name,
        "email": email,
        "license": license,
        "password": password,
      };

      final response = await ApiServices.instance.postData(
        endPoint: ApiEndPoints.signUp,
        body: payload,
        headers: {'Content-Type': 'application/json'},
      );

      final success = response["success"].toString().toLowerCase() == "true";
      if (success) {
        state = state.copyWith(isLoading: false,);
        return '${RouteName.signUpOtpScreen}/${Uri.encodeComponent(email)}';
      } else {
        state = state.copyWith(isLoading: false);

        return null;
      }
    } catch (e) {
      state = state.copyWith(isLoading: false);

      throw Exception(e);
    }
  }

  //signUp otp verify

  Future<String?> signUpOtpVerification({
    required String email,
    required String otp,
  }) async {
    state = state.copyWith(isLoading: true);

    try {
      final payload = {"email": email, "otp": otp};

      final response = await ApiServices.instance.postData(
        endPoint: ApiEndPoints.signUpOtp,
        body: payload,
        headers: {'Content-Type': 'application/json'},
      );

      final success = response["success"].toString().toLowerCase() == "true";
      final message = response["message"];

      if (success) {
        state = state.copyWith(isLoading: false);
        debugPrint(message);
        return RouteName.acountCreatedScreen;
      } else {
        state = state.copyWith(isLoading: false);
        return null;
      }
    } catch (e) {
      state = state.copyWith(isLoading: false);

      throw Exception(e);
    }
  }

  //forgetpass Send otp

  Future<String?> sendOtp({required String email}) async {
    state = state.copyWith(isLoading: true);
    try {
      final payload = {"email": email};
      final response = await ApiServices.instance.postData(
        endPoint: ApiEndPoints.sendOtp,
        body: payload,
        headers: {'Content-Type': 'application/json'},
      );

      final success = response["success"].toString().toLowerCase() == "true";
      final message = response["message"];

      if (success) {
        state = state.copyWith(isLoading: false);
        debugPrint(message);
        return RouteName.forgetOtpScreen;
      } else {
        state = state.copyWith(isLoading: false);
        return null;
      }
    } catch (e) {
      state = state.copyWith(isLoading: false);

      throw Exception(e);
    }
  }
}
