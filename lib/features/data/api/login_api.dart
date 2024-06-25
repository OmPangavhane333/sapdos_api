import 'package:http/http.dart' as http;
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
}
