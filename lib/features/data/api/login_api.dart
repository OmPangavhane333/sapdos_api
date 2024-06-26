import 'package:http/http.dart' as http;
import 'package:sapdos/features/presentation/doctor_screen/shared_preferences.dart';
import 'dart:convert';


class LoginApi {
  static Future<Map<String, dynamic>?> login(String email, String password) async {
    String url = 'https://sapdos-api-v2.azurewebsites.net/api/Credentials/Login';

    Map<String, String> body = {
      'userName': email,
      'password': password,
    };

    try {
      var response = await http.post(
        Uri.parse(url),
        headers: {
          'Content-Type': 'application/json',
        },
        body: jsonEncode(body),
      );

      if (response.statusCode == 200) {
        Map<String, dynamic> res = json.decode(response.body);
        // Save login info to shared preferences
        await saveLoginInfo(res);
        return res;
      } else {
        print('Failed to login. Status code: ${response.statusCode}');
        return null;
      }
    } catch (e) {
      print('Error during login: $e');
      return null;
    }
  }

  static Future<void> saveLoginInfo(Map<String, dynamic> userInfo) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('userInfo', jsonEncode(userInfo));
  }
}
