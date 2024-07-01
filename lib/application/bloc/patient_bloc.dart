import 'dart:async';
import 'dart:convert';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:sapdos/features/data/api/login_api.dart';
import 'package:sapdos/models/doctor.dart';
import 'package:sapdos/models/patient_details_model.dart';

class PatientBloc extends Cubit<PatientState> {
  PatientBloc() : super(PatientLoading());

  final String userId = '6b8fcda6-5c96-4ea6-8351-527cae571f59';
  
  BuildContext? get context => null;

  void fetchData() async {
    try {
      emit(PatientLoading());
      Map<String, dynamic> data = await fetchDoctorsFromJson();
      PatientDetailsModel? patientDetails = await getPatientByUId(userId);
      emit(PatientLoaded(data: data, patientDetails: patientDetails));
    } catch (e) {
      emit(PatientError(message: 'Failed to fetch data: $e'));
    }
  }

  Future<Map<String, dynamic>> fetchDoctorsFromJson() async {
    String jsonString = await DefaultAssetBundle.of(context!)
        .loadString('assets/doctors_list.json');
    Map<String, dynamic> jsonData = json.decode(jsonString);
    List<dynamic> doctorListJson = jsonData['doctorsList'];

    List<Doctor> doctors = doctorListJson
        .map((json) => Doctor(
              name: json['doctorName'] ?? 'Unknown Doctor',
              specialization: json['specialization'] ?? 'Unknown Specialization',
              rating: 0.0,
              doctorImage: json['doctorImage'] ?? '',
              appointmentIcon: json['appointmentIcon'] ?? '',
              price: (json['price'] ?? 0).toDouble(),
            ))
        .toList();

    return {'user': jsonData['user'] ?? {}, 'doctors': doctors};
  }

  Future<PatientDetailsModel?> getPatientByUId(String id) async {
    String base_url = "https://sapdos-api-v2.azurewebsites.net";

    try {
      final response = await http.get(Uri.parse("$base_url/api/Patient/GetPatientByUId?PatientUId=$id"));
      if (response.statusCode == 200) {
        dynamic jsonResponse = json.decode(response.body);
        if (jsonResponse is List) {
          jsonResponse = jsonResponse.first;
        }
        return PatientDetailsModel.fromJson(jsonResponse);
      } else {
        print('Error: status code ${response.statusCode}');
        throw Exception('Failed to fetch patient: ${response.reasonPhrase}');
      }
    } catch (e) {
      print("Error getPatientByUId: $e");
      throw Exception("Failed to fetch patient");
    }
  }
}

abstract class PatientState {}

class PatientLoading extends PatientState {}

class PatientLoaded extends PatientState {
  final Map<String, dynamic> data;
  final PatientDetailsModel? patientDetails;

  PatientLoaded({required this.data, required this.patientDetails});
}

class PatientError extends PatientState {
  final String message;

  PatientError({required this.message});
}

class PatientScreenBloc extends Cubit<PatientScreenState> {
  final Doctor doctor;
  DateTime _selectedDate = DateTime.now();

  PatientScreenBloc(this.doctor) : super(PatientScreenInitial());

  Future<void> selectDate(DateTime selectedDate) async {
    _selectedDate = selectedDate;
    emit(DateSelectedState(selectedDate: _selectedDate));
  }

  String getFormattedDate() {
    return DateFormat('yMMMd').format(_selectedDate);
  }
}

// Events
abstract class PatientScreenState {}

class PatientScreenInitial extends PatientScreenState {}

class DateSelectedState extends PatientScreenState {
  final DateTime selectedDate;

  DateSelectedState({required this.selectedDate});
}
