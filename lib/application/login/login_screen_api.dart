import 'package:http/http.dart' as http;
import 'dart:convert';

class AuthService {
  static const String baseUrl = 'https://sapdos-api-v2.azurewebsites.net/api';

  static Future<bool> register(String email, String password) async {
    String url = '$baseUrl/Credentials/Register';

    try {
      var response = await http.post(
        Uri.parse(url),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({'email': email, 'password': password}),
      );

      if (response.statusCode == 200) {
        return true; // Registration successful
      } else {
        // Registration failed
        print('Registration failed: ${response.body}');
        return false;
      }
    } catch (e) {
      print('Error during registration: $e');
      return false;
    }
  }

  static login(String email, String password) {}
}
