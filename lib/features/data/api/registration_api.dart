// lib/features/data/api/registration_api.dart
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:sapdos/features/presentation/login_screens/signup/signup_model.dart';


String baseUrl = "https://sapdos-api-v2.azurewebsites.net";

Future<bool> postSignup({required RegistrationModel registrationModel}) async {
  var registerEncodedJSON = json.encode(registrationModel.toJson());
  var headers = {"Content-Type": "application/json", "Accept": "*/*"};

  final response = await http.post(
    Uri.parse('$baseUrl/api/Credentials/Register'),
    body: registerEncodedJSON,
    headers: headers,
  );

  if (response.statusCode == 200) {
    print("Signup successful: ${response.body}");
    return true;
  } else if (response.statusCode == 400) {
    print("Failed to signup: Invalid Email ID");
    print('Response: ${response.body}');
    return false;
  } else {
    print("Failed to signup: ${response.body}");
    return false;
  }
}
