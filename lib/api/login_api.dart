import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:sapdos/features/presentation/doctor_screen/model/doctor_model.dart';


String base_url = "https://sapdos-api-v2.azurewebsites.net";

Future<List<DoctorModel>> getAllDoctor() async {
  try {
    final response = await http.get(Uri.parse('$base_url/api/Patient/GetAllUser?Role=doctor'));
    if (response.statusCode == 200) {
      List<dynamic> jsonList = json.decode(response.body);
      List<DoctorModel> doctors = jsonList.map((json) => DoctorModel.fromJson(json)).toList();
      return doctors;
    } else {
      return [];
    }
  } catch (e) {
    print('Error in getAllDoctor: $e');
    throw Exception('Failed to fetch doctors');
  }
}

Future<DoctorModel> GetDoctorByUId(String id) async {
  try {
    final response = await http.get(Uri.parse('$base_url/api/Patient/GetDoctorByUId?DoctorUId=$id'));
    if (response.statusCode == 200) {
      dynamic jsonResponse = json.decode(response.body);
      if (jsonResponse is List) {
        jsonResponse = jsonResponse.first;
      }
      DoctorModel doctor = DoctorModel.fromJson(jsonResponse);
      return doctor;
    } else {
      print('Error: status code ${response.statusCode}');
      throw Exception('Failed to fetch doctor');
    }
  } catch (e) {
    print('Error: $e');
    throw Exception('Failed to fetch doctor');
  }
}
