// TODO Implement this library.import 'package:http/http.dart' as http;
import 'dart:convert';

class AuthService {
  static const String baseUrl = 'https://sapdos-api-v2.azurewebsites.net/api';
  
  static get http => null;

  static Future<bool> login(String email, String password) async {
    String url = '$baseUrl/Credentials/Login';

    try {
      var response = await http.post(
        Uri.parse(url),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({'userName': email, 'password': password}),
      );

      if (response.statusCode == 200) {
        return true; // Login successful
      } else {
        print('Failed to login. Status code: ${response.statusCode}');
        return false; // Login failed
      }
    } catch (e) {
      print('Error during login: $e');
      return false;
    }
  }

  // Add other authentication-related methods as needed (e.g., register, logout)
}
