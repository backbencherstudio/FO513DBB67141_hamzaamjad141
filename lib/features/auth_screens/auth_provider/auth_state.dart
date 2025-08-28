import 'package:aviation_app/features/auth_screens/model/google_user_model.dart';
import 'package:aviation_app/features/auth_screens/model/user_model.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthState {
  final GoogleUserModel? googleUser;
  final UserModel? user;
  final String? message;
  final String? userToken;
  final User? appleUser; 
  final bool? isLoading;

  AuthState({this.googleUser, this.user, this.userToken, this.message, this.isLoading, this.appleUser});

  AuthState copyWith({
    GoogleUserModel? googleUser,
    UserModel? user,
        User? appleUser,

    String? userToken,
    bool? isLoading,
  }) {
    return AuthState(
      googleUser: googleUser ?? this.googleUser,
      user: user ?? this.user,
      appleUser: appleUser ?? this.appleUser,

      userToken: userToken ?? this.userToken,
      message: message ?? message,
        isLoading: isLoading ?? this.isLoading
    );
  }

  AuthState clearUser() {
    return AuthState(googleUser: null, user: null, userToken: null);
  }
}
