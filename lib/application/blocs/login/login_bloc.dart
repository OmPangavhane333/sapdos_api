import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'login_event.dart';
import 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  LoginBloc() : super(LoginInitial()) {
    on<LoginButtonPressed>(_onLoginButtonPressed);
  }

  Future<void> _onLoginButtonPressed(LoginButtonPressed event, Emitter<LoginState> emit) async {
    emit(LoginLoading());

    try {
      // API endpoint
      String url = 'https://sapdos-api-v2.azurewebsites.net/api/Credentials/Login';

      // Request body
      Map<String, String> body = {
        'userName': event.email,
        'password': event.password,
      };

      // Send POST request
      var response = await http.post(
        Uri.parse(url),
        headers: {
          'Content-Type': 'application/json',
        },
        body: jsonEncode(body),
      );

      // Handle response
      if (response.statusCode == 200) {
        // Successful login
        // Decode the response body
        Map<String, dynamic> data = jsonDecode(response.body);
        String token = data['token']; // Assuming token is returned from API
        String role = data['role']; // Assuming role is returned from API

        // Yield LoginSuccess state
        emit(LoginSuccess(token: token, role: role));
      } else {
        // Handle error
        emit(LoginFailure(error: 'Failed to login. Status code: ${response.statusCode}'));
      }
    } catch (error) {
      // Handle errors or exceptions during login
      emit(LoginFailure(error: 'Error during login: $error'));
    }
  }
}
