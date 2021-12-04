import 'package:shared_preferences/shared_preferences.dart';
import 'package:trivia/data/local/shared_constants.dart';

class SharedPrefs {
  static late final SharedPreferences _preferences;
  SharedPrefs._();
  factory SharedPrefs() => instance;
  static final SharedPrefs instance = SharedPrefs._();

  static Future<void> init() async {
    _preferences = await SharedPreferences.getInstance();
  }

  Future<bool> remove(String key) => _preferences.remove(key);

  Future<bool> call(final String key, final Object value) => set(key, value);

  Future<bool> set(final String key, final Object value) async {
    if (key.isEmpty) {
      return false;
    }
    if (value is int) {
      return _preferences.setInt(key, value);
    } else if (value is double) {
      return _preferences.setDouble(key, value);
    } else if (value is bool) {
      return _preferences.setBool(key, value);
    } else if (value is String) {
      return _preferences.setString(key, value);
    } else if (value is List<String>) {
      return _preferences.setStringList(key, value);
    }
    throw Exception('Invalid value type!');
  }

  Future<bool> clear() => _preferences.clear();

  String get privateKey => getString(SharedConstants.privateKey) ?? '';
  String? getString(final String key) => _preferences.getString(key);
  int? getInt(final String key) => _preferences.getInt(key);

  bool getBool(final String key, [final bool defaultValue = true]) =>
      _preferences.getBool(key) ?? defaultValue;
}
