import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class SecureStorage {
  AndroidOptions _getAndroidOptions() => const AndroidOptions(
        encryptedSharedPreferences: true,
      );

  final FlutterSecureStorage secureStorage = const FlutterSecureStorage();

  //Write Data
  writeSecureData(String key, String value) async {
    await secureStorage.write(key: key, value: value, aOptions: _getAndroidOptions());
  }

  //Read Data
  Future<String> readSecureData(String key) async {
    String value = await secureStorage.read(key: key, aOptions: _getAndroidOptions()) ?? 'No Data Found';
    return value;
  }

  //Delete Data
  deleteSecureData(String key) async {
    await secureStorage.delete(key: key, aOptions: _getAndroidOptions());
  }
}
