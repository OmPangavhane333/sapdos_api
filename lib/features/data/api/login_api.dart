import 'package:http/http.dart' as http;
import 'dart:convert';

Future<Map<String, dynamic>> login(String email, String password) async {
  
  String url = 'https://sapdos-api-v2.azurewebsites.net/api/Credentials/Login';

  
  Map<String, String> body = {
    'userName': email,
    'password': password,
  };

  
  var response = await http.post(
    Uri.parse(url),
    headers: {
      'Content-Type': 'application/json',
    },
    body: jsonEncode(body),
  );

  
  if (response.statusCode == 200) {
    
    Map<String, dynamic> data = jsonDecode(response.body);
    return data;
  } else {
    
    throw Exception('Failed to login. Status code: ${response.statusCode}');
  }
}
