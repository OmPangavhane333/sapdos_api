import 'dart:async';
import 'package:sapdos/features/presentation/login_screens/shared_preferences.dart';


class SessionManager {
  static final SessionManager _instance = SessionManager._internal();

  factory SessionManager() {
    return _instance;
  }

  SessionManager._internal();

  static Future<SessionManager> getInstance() async {
    await _instance._init();
    return _instance;
  }

  SharedPreferences? _prefs;

  Future<void> _init() async {
    _prefs = await SharedPreferences.getInstance();
  }

  static const String KEY_USER_ID = "userId";
  static const String KEY_AUTH_TOKEN = "authToken";

  Future<void> setSession(String userId, String authToken) async {
    await _prefs!.setString(KEY_USER_ID, userId);
    await _prefs!.setString(KEY_AUTH_TOKEN, authToken);
  }

  Future<Map<String, String?>> getSession() async {
    String? userId = _prefs!.getString(KEY_USER_ID);
    String? authToken = _prefs!.getString(KEY_AUTH_TOKEN);
    return {'userId': userId, 'authToken': authToken};
  }

  Future<void> clearSession() async {
    await _prefs!.remove(KEY_USER_ID);
    await _prefs!.remove(KEY_AUTH_TOKEN);
  }
}
