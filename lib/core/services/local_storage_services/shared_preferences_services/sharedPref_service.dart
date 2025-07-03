import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferenceStorageService {
  /// Save a string value
  static Future<void> saveString(String key, String value) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString(key, value);
    } catch (e) {
      throw Exception('Failed to save string: $e');
    }
  }

  /// Get a string value
  static Future<String?> getString({ required String key}) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      return prefs.getString(key);
    } catch (e) {
      throw Exception('Failed to get string: $e');
    }
  }

  /// Save an integer value
  static Future<void> saveInt({required String key, required  int value}) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setInt(key, value);
    } catch (e) {
      throw Exception('Failed to save int: $e');
    }
  }

  /// Get an integer value
  static Future<int?> getInt({required String key}) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      return prefs.getInt(key);
    } catch (e) {
      throw Exception('Failed to get int: $e');
    }
  }

  /// Save a boolean value
  static Future<void> saveBool(String key, bool value) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setBool(key, value);
    } catch (e) {
      throw Exception('Failed to save bool: $e');
    }
  }

  /// Get a boolean value
  static Future<bool?> getBool(String key) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      return prefs.getBool(key);
    } catch (e) {
      throw Exception('Failed to get bool: $e');
    }
  }

  /// Save a double value
  static Future<void> saveDouble(String key, double value) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setDouble(key, value);
    } catch (e) {
      throw Exception('Failed to save double: $e');
    }
  }

  /// Get a double value
  static Future<double?> getDouble(String key) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      return prefs.getDouble(key);
    } catch (e) {
      throw Exception('Failed to get double: $e');
    }
  }

  /// Save a list of strings
  static Future<void> saveStringList(String key, List<String> value) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setStringList(key, value);
    } catch (e) {
      throw Exception('Failed to save string list: $e');
    }
  }

  /// Get a list of strings
  static Future<List<String>?> getStringList(String key) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      return prefs.getStringList(key);
    } catch (e) {
      throw Exception('Failed to get string list: $e');
    }
  }

  /// Delete any value
  static Future<void> delete(String key) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.remove(key);
    } catch (e) {
      throw Exception('Failed to delete key: $e');
    }
  }

  /// Clear all shared preferences
  static Future<void> clearAll() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.clear();
    } catch (e) {
      throw Exception('Failed to clear preferences: $e');
    }
  }
}
