import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import '../../../features/auth_screens/model/google_user_model.dart';

class GoogleAccountService {
  final GoogleSignIn _googleSignIn = GoogleSignIn();

  /// Sign In method
  Future<GoogleUserModel?> signInWithGoogle() async {
    try {
      final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();
      debugPrint("\nsign in completed\n");
      if (googleUser == null) {
        debugPrint("\nUser canceled the sign-in process.\n");
        return null;
      } else {
        debugPrint("\ngoogle user name : ${googleUser.displayName}\n");
        debugPrint("\ngoogle user email : ${googleUser.email}\n");
        debugPrint("\ngoogle user profile picture : ${googleUser.photoUrl}\n");
        debugPrint("\ngoogle user profile picture : ${googleUser.id}\n");
        return GoogleUserModel(
          id: googleUser.id,
          fullName: googleUser.displayName ?? "",
          email: googleUser.email,
          photoUrl: googleUser.photoUrl ?? "",
        );
      }
    } catch (e) {
      throw Exception("\nError while google sign in : $e\n");
    }
  }

  /// Sign Out method
  Future<void> signOut() async {
    await _googleSignIn.signOut();
  }
}
