import 'package:aviation_app/features/auth_screens/model/google_user_model.dart';
import 'package:aviation_app/features/auth_screens/model/user_model.dart';

class AuthState {
  final GoogleUserModel? googleUser;
  final UserModel? user;
  final String? userToken;

  AuthState({this.googleUser, this.user, this.userToken});

  AuthState copyWith({
    GoogleUserModel? googleUser,
    UserModel? user,
    String? userToken,
  }) {
    return AuthState(
      googleUser: googleUser ?? this.googleUser,
      user: user ?? this.user,
      userToken: userToken ?? this.userToken,
    );
  }

  AuthState clearUser() {
    return AuthState(googleUser: null, user: null, userToken: null);
  }
}
