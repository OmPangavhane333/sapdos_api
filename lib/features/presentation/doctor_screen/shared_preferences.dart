import 'dart:async';

class SharedPreferences {
  static final SharedPreferences _instance = SharedPreferences._internal();
  factory SharedPreferences() {
    return _instance;
  }
  SharedPreferences._internal();

  static Future<SharedPreferences> getInstance() async {
    return _instance;
  }

  Map<String, String> _storage = {};

  Future<bool> setString(String key, String value) async {
    _storage[key] = value;
    return true;
  }

  String? getString(String key) {
    return _storage[key];
  }
}
