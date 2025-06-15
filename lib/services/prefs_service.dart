import 'package:shared_preferences/shared_preferences.dart';

class PrefsService {
  static final PrefsService _instance = PrefsService._internal();

  factory PrefsService() => _instance;

  SharedPreferences? _prefs;

  PrefsService._internal();

  Future<void> init() async {
    _prefs ??= await SharedPreferences.getInstance();
  }

  Future<void> setString(String key, String value) async {
    await init();
    await _prefs?.setString(key, value);
  }

  Future<String?> getString(String key) async {
    await init();
    return _prefs?.getString(key);
  }

  Future<void> setBool(String key, bool value) async {
    await init();
    await _prefs?.setBool(key, value);
  }

  Future<bool?> getBool(String key) async {
    await init();
    return _prefs?.getBool(key);
  }

  Future<void> remove(String key) async {
    await init();
    await _prefs?.remove(key);
  }

  Future<void> clear() async {
    await init();
    await _prefs?.clear();
  }

}
