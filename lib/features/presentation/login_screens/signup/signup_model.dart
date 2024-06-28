import 'package:flutter/foundation.dart';

class RegistrationModel {
  final String name;
  final String email;
  final String age;
  final String phone;
  final String address;
  final String specialization;
  final int experience;
  final String password;

  RegistrationModel({
    required this.name,
    required this.email,
    required this.age,
    required this.phone,
    required this.address,
    required this.specialization,
    required this.experience,
    required this.password,
  });

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'email': email,
      'age': age,
      'phone': phone,
      'address': address,
      'specialization': specialization,
      'experience': experience,
      'password': password,
    };
  }
}
