import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:sapdos/features/presentation/doctor_screen/model/doctor_model.dart';

const String baseUrl = "https://sapdos-api-v2.azurewebsites.net";

class ApiService {
  static Future<DoctorModel> getDoctorByUId(String id) async {
    try {
      final response = await http.get(Uri.parse('$baseUrl/api/Doctor/GetDoctorByUId?DoctorUId=$id'));
      if (response.statusCode == 200) {
        dynamic jsonResponse = json.decode(response.body);
        if (jsonResponse is List) {
          jsonResponse = jsonResponse.first;
        }
        DoctorModel doctor = DoctorModel.fromJson(jsonResponse);
        return doctor;
      } else {
        throw Exception('Failed to fetch doctor: ${response.reasonPhrase}');
      }
    } catch (e) {
      print('Error in getDoctorByUId: $e');
      throw Exception('Failed to fetch doctor');
    }
  }
}
