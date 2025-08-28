import 'dart:convert';
import 'dart:math';
import 'package:crypto/crypto.dart'; 
import 'package:aviation_app/core/routes/route_name.dart';
import 'package:aviation_app/core/services/api_services/api_endpoints.dart';
import 'package:aviation_app/core/services/api_services/api_services.dart';
import 'package:aviation_app/core/services/local_storage_services/shared_preferences_services/sharedPref_service.dart';
import 'package:aviation_app/core/services/local_storage_services/shared_preferences_services/shared_preferences_key_name.dart';
import 'package:aviation_app/features/auth_screens/auth_provider/auth_state.dart';
import 'package:aviation_app/features/auth_screens/model/user_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:sign_in_with_apple/sign_in_with_apple.dart';
import '../../../core/services/google_account_services/google_account_service.dart';

final authProvider = StateNotifierProvider<AuthProvider, AuthState>((ref) {
  return AuthProvider();
});

class AuthProvider extends StateNotifier<AuthState> {
  AuthProvider() : super(AuthState());

  Future<void> resendOtp({required String email})async{
    try{
      final rawResponse = await http.patch(Uri.parse('${ApiEndPoints.baseUrl}/${ApiEndPoints.resendOtp}'),
      body: jsonEncode({
        "email":email
      },
      ),
          headers: {"Content-Type":"application/json"}
      );
      final response = jsonDecode(rawResponse.body);
      // ApiServices.instance.postData(endPoint: ApiEndPoints.resendOtp, body: {
      //   "email":email
      // }, headers: {"Content-Type":"application/json"});
      if(response['success'] == true){
        Fluttertoast.showToast(msg: "Otp sent successfully",backgroundColor: Colors.green,textColor: Colors.white);
      }
    }catch(error){
      Fluttertoast.showToast(msg: "Otp sent failed",backgroundColor: Colors.red,textColor: Colors.white);

      throw Exception('Error while resending otp : $error');
    }
  }







//====================apple===================
Future<String> createAccountWithApple() async {
  try {
    // Generate a secure random nonce
    String generateNonce([int length = 32]) {
      const charset =
          '0123456789ABCDEFGHIJKLMNOPQRSTUVXYZabcdefghijklmnopqrstuvwxyz-._';
      final random = Random.secure();
      return List.generate(length, (_) => charset[random.nextInt(charset.length)])
          .join();
    }

    // Hash string to SHA256
    String sha256ofString(String input) {
      final bytes = utf8.encode(input);
      final digest = sha256.convert(bytes);
      return digest.toString();
    }

    final rawNonce = generateNonce();
    final nonce = sha256ofString(rawNonce);

    // Request Apple credentials with proper configuration
    final appleCredential = await SignInWithApple.getAppleIDCredential(
      scopes: [
        AppleIDAuthorizationScopes.email,
        AppleIDAuthorizationScopes.fullName,
      ],
      nonce: nonce,
      webAuthenticationOptions: WebAuthenticationOptions(
        // Use the redirect URL from Firebase
        clientId: nonce,
        redirectUri: Uri.parse('https://lslapp-c4989.firebaseapp.com/__/auth/handler'),
      ),
    );

    debugPrint("🍎 Apple credential: "
        "email=${appleCredential.email}, "
        "name=${appleCredential.givenName} ${appleCredential.familyName}, "
        "idToken=${appleCredential.identityToken}, "
        "authCode=${appleCredential.authorizationCode}");

    // Verify the identity token is not null
    if (appleCredential.identityToken == null) {
      debugPrint("❌ Apple identityToken is null");
      Fluttertoast.showToast(
        msg: "Apple sign-in failed: No identity token",
        backgroundColor: Colors.red,
        textColor: Colors.white
      );
      return RouteName.signInScreen;
    }

    // Firebase OAuth credential
    final oauthCredential = OAuthProvider("apple.com").credential(
      idToken: appleCredential.identityToken,
      rawNonce: rawNonce,
    );

    final userCredential = await FirebaseAuth.instance.signInWithCredential(oauthCredential);

    // If Firebase sign-in succeeds
    if (userCredential.user != null) {
      final user = userCredential.user;

      // Apple gives email/name only on first login → fallback otherwise
      String name = "Apple User";
      if (appleCredential.givenName != null && appleCredential.familyName != null) {
        name = "${appleCredential.givenName} ${appleCredential.familyName}";
      } else if (user?.displayName != null) {
        name = user!.displayName!;
      }

      String email = user?.email ?? "";
      if (appleCredential.email != null) {
        email = appleCredential.email!;
      }

      // If email is still empty, try to get it from Firebase user
      if (email.isEmpty) {
        // Refresh user data to get email if available
        await user?.reload();
        final refreshedUser = FirebaseAuth.instance.currentUser;
        email = refreshedUser?.email ?? "";
      }

      // Prepare API request for Apple login
      final body = {
        "name": name,
        "email": email,
        "image": "https://as2.ftcdn.net/v2/jpg/02/70/34/31/1000_F_270343143_8pIbNFLxRNAEfK8uQv8JRpLtR9X9nlIm.jpg", 
        "idToken": appleCredential.identityToken,
        "authorizationCode": appleCredential.authorizationCode,
        "provider": "apple",
        "firebaseUid": user?.uid, // Send Firebase UID for better identification
      };

      final headers = {"Content-Type": "application/json"};

      // Try Apple endpoint first, fallback to Google if not available
      final String endpoint =  ApiEndPoints.googleLogin;
      
      debugPrint("📡 Calling endpoint: $endpoint");
      debugPrint("📦 Request body: $body");

      final response = await ApiServices.instance.postData(
        endPoint: endpoint,
        body: body,
        headers: headers,
      );

      debugPrint("\n🍎 Apple Login API Response: $response\n");

      if (response == null || response['success'] != true) {
        debugPrint("❌ Apple Login failed on backend: ${response?['message']}");
        Fluttertoast.showToast(
          msg: response?['message'] ?? "Apple login failed. Please try again.",
          backgroundColor: Colors.red,
          textColor: Colors.white
        );
        
        // Sign out from Firebase if backend failed
        await FirebaseAuth.instance.signOut();
        return RouteName.signInScreen;
      }

      // Parse user
      final UserModel userModel = UserModel.fromJson(response['user']);
      final userToken = response['token'];

      // Save user token locally
      await SharedPreferenceStorageService.saveString(
        SharedPreferencesKeyName.userToken,
        userToken ?? "",
      );

      // Update app state
      state = state.copyWith(
        appleUser: user,
        user: userModel,
        userToken: userToken,
      );

      // Debugging
      debugPrint("\n=== APPLE LOGIN SUCCESS ===");
      debugPrint("User Name: ${userModel.name}");
      debugPrint("User Email: ${userModel.email}");
      debugPrint("User Premium: ${userModel.premium}");
      debugPrint("User Token: $userToken");
      debugPrint("==========================\n");

      // Show success message
      Fluttertoast.showToast(
        msg: "Apple sign-in successful",
        backgroundColor: Colors.green,
        textColor: Colors.white
      );

      // Redirect based on premium status
      return userModel.premium == true
          ? RouteName.weatherScreen
          : RouteName.paymentIntro;
    }

    return RouteName.signInScreen;
  } on SignInWithAppleAuthorizationException catch (e) {
    debugPrint("❌ Apple Authorization Exception: ${e.code} - ${e.message}");
    
    if (e.code == AuthorizationErrorCode.canceled) {
      debugPrint("🚪 User canceled Apple sign-in");
      Fluttertoast.showToast(
        msg: "Apple sign-in cancelled",
        backgroundColor: Colors.orange,
        textColor: Colors.white
      );
    } else if (e.code == AuthorizationErrorCode.invalidResponse) {
      debugPrint("❌ Invalid response from Apple");
      Fluttertoast.showToast(
        msg: "Invalid response from Apple. Please try again.",
        backgroundColor: Colors.red,
        textColor: Colors.white
      );
    } else {
      debugPrint("❌ Other Apple auth error: $e");
      Fluttertoast.showToast(
        msg: "Apple sign-in failed. Please try again.",
        backgroundColor: Colors.red,
        textColor: Colors.white
      );
    }
    return RouteName.signInScreen;
  } on FirebaseAuthException catch (e) {
    debugPrint("❌ Firebase Auth Exception: ${e.code} - ${e.message}");
    Fluttertoast.showToast(
      msg: "Authentication failed: ${e.message}",
      backgroundColor: Colors.red,
      textColor: Colors.white
    );
    return RouteName.signInScreen;
  } catch (error, stack) {
    debugPrint("❌ Apple Sign-In Exception: $error");
    debugPrint("Stack: $stack");
    Fluttertoast.showToast(
      msg: "An error occurred during Apple sign-in",
      backgroundColor: Colors.red,
      textColor: Colors.white
    );
    return RouteName.signInScreen;
  }
}

//=========================================
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
        
        // Enhanced debugging for premium access during Google login
        debugPrint("\n=== GOOGLE LOGIN ACCESS CONTROL DEBUG ===");
        debugPrint("user.premium value: ${user.premium}");
        debugPrint("user.premium type: ${user.premium.runtimeType}");
        debugPrint("user.premium == true: ${user.premium == true}");
        debugPrint("Raw response['user']['premium']: ${response['user']['premium']}");
        debugPrint("==========================================\n");
        
        if (user.premium == true) {
          debugPrint("\n✅ Premium Google user detected. Redirecting to weather screen.\n");
          return RouteName.weatherScreen;
        } else {
          debugPrint("\n❌ Non-premium Google user. Redirecting to payment screen.\n");
          return RouteName.paymentIntro;
        }

        //
      }
      return RouteName.signInScreen;
    } catch (error) {
      throw Exception(
        '\nException while creating account with google++++++++++++++++ : $error\n',
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
        final user = UserModel.fromJson(userJson);
        state = state.copyWith(isLoading: false, userToken: token, user: user);
        debugPrint("Login successful. User ID: ${state.user?.id}");

        // Enhanced debugging for premium access during login
        debugPrint("\n=== LOGIN ACCESS CONTROL DEBUG ===");
        debugPrint("user.premium value: ${user.premium}");
        debugPrint("user.premium type: ${user.premium.runtimeType}");
        debugPrint("user.premium == true: ${user.premium == true}");
        debugPrint("Raw userJson['premium']: ${userJson['premium']}");
        debugPrint("======================================\n");

        if (user.premium == true) {
          debugPrint("\n✅ Premium user detected. Redirecting to weather screen.\n");
          return RouteName.weatherScreen;
        } else {
          debugPrint("\n❌ Non-premium user. Redirecting to payment screen.\n");
          return RouteName.paymentIntro;
        }

        //
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
  }) async
  {
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
        state = state.copyWith(isLoading: false);
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
  }) async
  {
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
        return "${RouteName.forgetOtpScreen}/${Uri.encodeComponent(email)}";
      } else {
        state = state.copyWith(isLoading: false);
        return null;
      }
    } catch (e) {
      state = state.copyWith(isLoading: false);

      throw Exception(e);
    }
  }

  //forget otp call

  Future<String?> forgetOtpVerification({
    required String email,
    required String otp,
  }) async
  {
    state = state.copyWith(isLoading: true);

    try {
      final payload = {"email": email, "otp": otp};

      final response = await ApiServices.instance.postData(
        endPoint: ApiEndPoints.forgetOtp,
        body: payload,
        headers: {'Content-Type': 'application/json'},
      );

      // final success = response["success"].toString().toLowerCase() == "true";
      final message = response["message"];
      debugPrint("\n\n$response\n\n");
      if (message == "OTP verified successfully") {
        state = state.copyWith(isLoading: false);
        debugPrint(message);
        return "${RouteName.resetPassScreen}/${Uri.encodeComponent(email)}";
      } else {
        state = state.copyWith(isLoading: false);
        return null;
      }
    } catch (e) {
      state = state.copyWith(isLoading: false);

      throw Exception(e);
    }
  }

  // reset password

  Future<String?> resetpassCall({
    required String email,
    required String password,
  }) async
  {
    state = state.copyWith(isLoading: true);

    try {
      final payload = {"email": email, "newPassword": password};

      final response = await ApiServices.instance.putData(
        endPoint: ApiEndPoints.resetpass,
        body: payload,
        headers: {'Content-Type': 'application/json'},
      );
      final message = response["message"];

      if (message == "Password changed successfully") {
        state = state.copyWith(isLoading: false);

        return RouteName.successScreen;
      } else {
        state = state.copyWith(isLoading: false);

        return null;
      }
    } catch (e) {
      state = state.copyWith(isLoading: false);

      throw Exception(e);
    }
  }

  /// Call this api during splash screen to initialize user
  Future<UserModel?> initializeUser({required String userToken}) async
  {
    try {
      final response = await ApiServices.instance.getData(
        endPoint: ApiEndPoints.initializeUser,
        headers: {"Authorization": userToken},
      );
      if (response["success"] == true) {
        debugPrint("\nUser Initialized successful\n");
        final user = UserModel.fromJson(response["user"]);
        state = state.copyWith(user: user, userToken: userToken);
        debugPrint("\nuser token after initializing : ${state.userToken}\n");
        return user;
      } else {
        debugPrint("\nUser Initialized failed\n");
        return null;
      }
    } catch (error) {
      return null;
    }
  }

  Future<bool?> signOut() async
  {
    try {
      await GoogleAccountService().signOut();
      await SharedPreferenceStorageService.delete(
        SharedPreferencesKeyName.userToken,
      );
      return true;
    } catch (error) {
      return false;
    }
  }

  Future<bool?> updateUserModel() async {
    try{
    await  initializeUser(userToken: state.userToken ?? "");
    return true;
    }catch(error){
      throw Exception('Error while updating profile : $error');
    }
  }
}
