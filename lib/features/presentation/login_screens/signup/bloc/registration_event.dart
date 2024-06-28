import 'package:equatable/equatable.dart';
import 'package:sapdos/features/presentation/login_screens/signup/signup_model.dart';


abstract class RegistrationEvent extends Equatable {
  const RegistrationEvent();

  @override
  List<Object?> get props => [];
}

class RegisterButtonPressed extends RegistrationEvent {
  final RegistrationModel registrationModel;

  const RegisterButtonPressed({required this.registrationModel});

  @override
  List<Object?> get props => [registrationModel];
}
