import 'dart:async';
import 'dart:convert';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;
import 'package:sapdos/features/presentation/doctor_screen/model/doctor_model.dart';

class DoctorBloc extends Cubit<DoctorState> {
  DoctorBloc() : super(DoctorLoading());

  String base_url = "https://sapdos-api-v2.azurewebsites.net";

  Future<void> fetchDoctor(String uid) async {
    try {
      emit(DoctorLoading());
      DoctorModel fetchedDoctor = await getDoctorByUId(uid);
      emit(DoctorLoaded(doctor: fetchedDoctor));
    } catch (e) {
      emit(DoctorError(message: 'Failed to fetch doctor: $e'));
    }
  }

  Future<DoctorModel> getDoctorByUId(String id) async {
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
        throw Exception('Failed to fetch doctor: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Failed to fetch doctor: $e');
    }
  }
}

abstract class DoctorState {}

class DoctorLoading extends DoctorState {}

class DoctorLoaded extends DoctorState {
  final DoctorModel doctor;

  DoctorLoaded({required this.doctor});
}

class DoctorError extends DoctorState {
  final String message;

  DoctorError({required this.message});
}
