import 'dart:convert';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:hive_flutter/hive_flutter.dart';

class HiveSecureStorageService {
  static const _keyName = "encryption_key";
  static const _boxName = 'secureBox';
  static final _secureStorage = const FlutterSecureStorage();

  /// Initialize Hive. Call this method from main method
  static Future<void> init() async {
    await Hive.initFlutter();
    final encryptionKey = await _getEncryptionKey();
    await Hive.openBox(
      _boxName,
      encryptionCipher: HiveAesCipher(encryptionKey),
    );
  }

  /// get an encryption key for hive. Call this method only once from the init method.
  static Future<List<int>> _getEncryptionKey() async {
    final encodedKey = await _secureStorage.read(key: _keyName);
    if (encodedKey != null) {
      return base64Url.decode(encodedKey);
    } else {
      final encryptionKey = Hive.generateSecureKey();
      await _secureStorage.write(
        key: _keyName,
        value: base64UrlEncode(encryptionKey),
      );
      return encryptionKey;
    }
  }

  /// save to hive securely (data will be auto encrypted)
  static Future<void> saveToHive({
    required String key,
    required Map<String, dynamic> data,
  }) async {
    try {
      final box = Hive.box(_boxName);
      final jsonString = jsonEncode(data);
      await box.put(key, jsonString);
    } catch (e) {
      throw Exception(
        '\nFailed to save data in hive box. Please ensure you pass the data as Map<String, dynamic>.\nError : $e\n',
      );
    }
  }

  /// get from hive
  static Future<dynamic> getFromHive({required String key}) async {
    try {
      final box = Hive.box(_boxName);
      final jsonString = await box.get(key);
      if (jsonString == null) return null;
      return Map<String, dynamic>.from(jsonDecode(jsonString));
    } catch (e) {
      throw Exception('\nFailed to get from hive box: $e\n');
    }
  }
}
