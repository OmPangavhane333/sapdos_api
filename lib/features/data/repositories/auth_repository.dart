import 'package:http/http.dart' as http;
import 'dart:convert';

class AuthRepository {
  final String _baseUrl = 'https://sapdos-api-v2.azurewebsites.net/api/Credentials';

  Future<bool> login(String email, String password) async {
    final url = Uri.parse('$_baseUrl/Login');
    final body = {'userName': email, 'password': password};

    final response = await http.post(
      url,
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(body),
    );

    if (response.statusCode == 200) {
      return true;
    } else {
      return false;
    }
  }

  Future<bool> register(String email, String password) async {
    final url = Uri.parse('$_baseUrl/Register');
    final body = {'email': email, 'password': password};

    final response = await http.post(
      url,
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(body),
    );

    if (response.statusCode == 200) {
      return true;
    } else {
      return false;
    }
  }
}
