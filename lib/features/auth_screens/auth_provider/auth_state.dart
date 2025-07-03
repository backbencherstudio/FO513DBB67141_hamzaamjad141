import 'package:aviation_app/features/auth_screens/model/google_user_model.dart';

class AuthState {
  final GoogleUserModel? googleUser;
  AuthState({this.googleUser});
  AuthState copyWith({GoogleUserModel? googleUser}) {
    return AuthState(googleUser: googleUser ?? this.googleUser);
  }

  AuthState clearGoogleUser() {
    return AuthState(googleUser: null);
  }
}
