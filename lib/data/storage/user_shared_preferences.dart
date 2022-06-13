import 'package:shared_preferences/shared_preferences.dart';

class UserSharedPreferences {
  static SharedPreferences? _preferences;
  static Future init() async =>
      _preferences = await SharedPreferences.getInstance();

  static const _keyEmail = "email";
  static Future setEmail(String email) async =>
      await _preferences?.setString(_keyEmail, email);

  static String? getEmail() => _preferences?.getString(_keyEmail);

  static void deleteEmail() async => await _preferences?.remove(_keyEmail);

  static bool? containsEmail() {
    bool val = _preferences!.containsKey(_keyEmail);
    return val ? true : null;
  }
}
