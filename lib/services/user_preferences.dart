import 'package:sapdos/features/presentation/doctor_screen/shared_preferences.dart';


class UserPreferences {
  static const String _userUidKey = 'userUid';

  // Save user info (example)
  static Future<void> saveUserInfo(String userUid) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString(_userUidKey, userUid);
  }

  // Get user info (example)
  static Future<Map<String, dynamic>?> getUserInfo() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? userUid = prefs.getString(_userUidKey);

    if (userUid != null) {
      return {'userUid': userUid};
    } else {
      return null;
    }
  }

  // Clear user info (example, if needed)
  static Future<void> clearUserInfo() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove(_userUidKey);
  }
}
