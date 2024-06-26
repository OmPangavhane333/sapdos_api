import 'package:http/http.dart' as http;
import 'dart:convert';

class AuthRepository {
  final String _baseUrl = 'https://sapdos-api-v2.azurewebsites.net/api/Credentials';

  Future<bool> login(String email, String password) async {
    final url = Uri.parse('$_baseUrl/Login');
    final body = {'userName': email, 'password': password};

    try {
      final response = await http.post(
        url,
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode(body),
      );

      if (response.statusCode == 200) {
        return true;
      } else {
        // Handle other status codes
        print('Login failed with status code: ${response.statusCode}');
        return false;
      }
    } catch (e) {
      // Handle network and other errors
      print('Error during login: $e');
      return false;
    }
  }

  Future<bool> register(String email, String password) async {
    final url = Uri.parse('$_baseUrl/Register');
    final body = {'email': email, 'password': password};

    try {
      final response = await http.post(
        url,
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode(body),
      );

      if (response.statusCode == 200) {
        return true;
      } else {
        // Handle other status codes
        print('Registration failed with status code: ${response.statusCode}');
        return false;
      }
    } catch (e) {
      // Handle network and other errors
      print('Error during registration: $e');
      return false;
    }
  }

  signIn(String email, String password) {}

  signOut() {}

  getUserByEmail(String email) {}
}
