import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class EncryptedSharedPrefManager {
  static EncryptedSharedPrefManager? _instance;
  final FlutterSecureStorage _encryptedSharedPreference;

  EncryptedSharedPrefManager._(FlutterSecureStorage encryptedSharedPreference)
      : _encryptedSharedPreference = encryptedSharedPreference;

  static EncryptedSharedPrefManager? getInstance() {
    if (_instance == null) {
      const sharedPreferences = FlutterSecureStorage();
      _instance = EncryptedSharedPrefManager._(sharedPreferences);
    }
    return _instance;
  }

  saveEncryptedData(String key, dynamic value) async {
    await _encryptedSharedPreference.write(key: key, value: value);
  }

  Future<dynamic> retrieveEncryptedData(String key) async {
    return await _encryptedSharedPreference.read(
          key: key,
        ) ??
        null;
  }

  deleteEncryptedData(String key) async {
    await _encryptedSharedPreference.delete(
      key: key,
    );
  }
}
