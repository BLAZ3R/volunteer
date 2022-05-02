import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class UserSecureStorage {
  static final _storage = FlutterSecureStorage();
  static const _keyToken = 'token';
  static Future setToken(String token) async =>
      await _storage.write(key: _keyToken, value: token);

  static Future<bool> containsToken() async =>
      await _storage.containsKey(key: _keyToken);

  static Future<void> deleteAll() async {
    return _storage.deleteAll();
  }

  static Future<String?> getToken() async =>
      await _storage.read(key: _keyToken);

  static Future<void> deleteToken() async =>
      await _storage.delete(key: _keyToken);
}
