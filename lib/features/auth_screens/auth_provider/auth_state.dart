import 'package:aviation_app/features/auth_screens/model/google_user_model.dart';
import 'package:aviation_app/features/auth_screens/model/user_model.dart';

class AuthState {
  final GoogleUserModel? googleUser;
  final UserModel? user;
  final String? message;
  final String? userToken;
  final bool? isLoading;

  AuthState({this.googleUser, this.user, this.userToken, this.message, this.isLoading});

  AuthState copyWith({
    GoogleUserModel? googleUser,
    UserModel? user,
    String? userToken,
    bool? isLoading,
  }) {
    return AuthState(
      googleUser: googleUser ?? this.googleUser,
      user: user ?? this.user,
      userToken: userToken ?? this.userToken,
      message: message ?? this.message,
        isLoading: isLoading ?? this.isLoading
    );
  }

  AuthState clearUser() {
    return AuthState(googleUser: null, user: null, userToken: null);
  }
}
