import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferencesService {
  static final SharedPreferencesService _instance = SharedPreferencesService._privateConstructor();
  static late SharedPreferences _preferences;

  /// keys
  static const String _darkModeKey = "dark_mode";

  SharedPreferencesService._privateConstructor();

  static Future<SharedPreferencesService> init() async {
    _preferences = await SharedPreferences.getInstance();
    return _instance;
  }

  static SharedPreferencesService get i => _instance;

  /// dark mode
  bool isDarkMode() => _preferences.getBool(_darkModeKey) ?? false;

  void setDarkMode(bool value) {
    _preferences.setBool(_darkModeKey, value);
  }

  /// remove key
  Future<bool> removeKey(String key) async {
    return await _preferences.remove(key);
  }

  /// clear all keys
  Future<bool> clearAll() async {
    return await _preferences.clear();
  }
}
