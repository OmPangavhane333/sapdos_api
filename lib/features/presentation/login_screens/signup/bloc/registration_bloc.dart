import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'registration_event.dart';
import 'registration_state.dart';


class RegistrationBloc extends Bloc<RegistrationEvent, RegistrationState> {
  RegistrationBloc() : super(RegistrationInitial()) {
    on<RegisterButtonPressed>(_onRegisterButtonPressed);
  }

  Future<void> _onRegisterButtonPressed(RegisterButtonPressed event, Emitter<RegistrationState> emit) async {
    emit(RegistrationLoading());

    try {
      String url = 'https://sapdos-api-v2.azurewebsites.net/api/Credentials/Register';

      var response = await http.post(
        Uri.parse(url),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode(event.registrationModel.toJson()),
      );

      if (response.statusCode == 200) {
        emit(RegistrationSuccess());
      } else {
        emit(RegistrationFailure(error: 'Failed to register. Status code: ${response.statusCode}'));
      }
    } catch (error) {
      emit(RegistrationFailure(error: 'Error during registration: $error'));
    }
  }
}
