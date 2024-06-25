// registration_api.dart

import 'dart:convert';
import 'package:http/http.dart' as http;

class RegistrationApi {
  static Future<Map<String, dynamic>?> registerUser(Map<String, dynamic> requestBody) async {
    String url = 'https://sapdos-api-v2.azurewebsites.net/api/Credentials/Register';

    try {
      var response = await http.post(
        Uri.parse(url),
        headers: {
          'Content-Type': 'application/json',
        },
        body: jsonEncode(requestBody),
      );

      if (response.statusCode == 200) {
        return jsonDecode(response.body);
      } else {
        throw Exception('Failed to register: ${jsonDecode(response.body)['message']}');
      }
    } catch (e) {
      print('Error: $e');
      throw Exception('Error during registration. Please try again.');
    }
  }
}
