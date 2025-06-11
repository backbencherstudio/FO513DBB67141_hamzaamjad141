import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class SecureAuthTokenStorageService {
  static final _flutterSecureStorage = FlutterSecureStorage();
  static final String _authTokenKey = 'auth_token';

  /// Save authentication token securely
  static Future<void> saveAuthToken(String token) async {
    try {
      await _flutterSecureStorage.write(key: _authTokenKey, value: token);
    } catch (e) {
      throw Exception('Failed to save auth token: $e');
    }
  }

  /// Get authentication token securely
  static Future<String?> getAuthToken() async {
    try {
      return await _flutterSecureStorage.read(key: _authTokenKey);
    } catch (e) {
      throw Exception('Failed to read auth token: $e');
    }
  }

  /// Delete authentication token securely
  static Future<void> deleteAuthToken() async {
    try {
      await _flutterSecureStorage.delete(key: _authTokenKey);
    } catch (e) {
      throw Exception('Failed to delete auth token: $e');
    }
  }
}
