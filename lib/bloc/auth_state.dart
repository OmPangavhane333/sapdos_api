import 'package:equatable/equatable.dart';

abstract class AuthState extends Equatable {
  final String email;
  final String password;

  const AuthState({required this.email, required this.password});

  @override
  List<Object?> get props => [email, password];
}

class AuthInitial extends AuthState {
  const AuthInitial({String email = '', String password = ''})
      : super(email: email, password: password);
}

class AuthLoading extends AuthState {
  const AuthLoading({String email = '', String password = ''})
      : super(email: email, password: password);
}

class AuthAuthenticated extends AuthState {
  final String userUid;

  const AuthAuthenticated({
    required this.userUid,
    required String email,
    required String password,
  }) : super(email: email, password: password);

  @override
  List<Object?> get props => [userUid, email, password];
}

class AuthFailure extends AuthState {
  final String error;

  const AuthFailure({
    required this.error,
    String email = '',
    String password = '',
  }) : super(email: email, password: password);

  @override
  List<Object?> get props => [error, email, password];
}

class FormValid extends AuthState {
  const FormValid({String email = '', String password = ''})
      : super(email: email, password: password);
}

class EmailInvalid extends AuthState {
  final String error;

  const EmailInvalid({
    required this.error,
    String email = '',
    String password = '',
  }) : super(email: email, password: password);

  @override
  List<Object?> get props => [error, email, password];
}

class PasswordInvalid extends AuthState {
  final String error;

  const PasswordInvalid({
    required this.error,
    String email = '',
    String password = '',
  }) : super(email: email, password: password);

  @override
  List<Object?> get props => [error, email, password];
}
