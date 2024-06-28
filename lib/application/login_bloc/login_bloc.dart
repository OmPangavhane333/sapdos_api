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
      
      String url = 'https://sapdos-api-v2.azurewebsites.net/api/Credentials/Login';

      
      Map<String, String> body = {
        'userName': event.email,
        'password': event.password,
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
        String token = data['token']; 
        String role = data['role'];

        
        emit(LoginSuccess(token: token, role: role));
      } else {
       
        emit(LoginFailure(error: 'Failed to login. Status code: ${response.statusCode}'));
      }
    } catch (error) {
      
      emit(LoginFailure(error: 'Error during login: $error'));
    }
  }
}
