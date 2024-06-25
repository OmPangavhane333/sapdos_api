import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sapdos/features/presentation/doctor_screen/doctor_screen1.dart';
import 'package:sapdos/features/presentation/doctor_screen/doctor_screen2.dart';
import 'package:sapdos/features/presentation/login_screens/login_screen1.dart';
import 'package:sapdos/features/presentation/login_screens/login_screen2.dart';
import 'package:sapdos/features/presentation/login_screens/login_screen3.dart';
import 'package:sapdos/features/presentation/patient_screens/patient_screen1.dart';
import 'package:sapdos/bloc/auth_bloc.dart'; // Import your AuthBloc

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'SAPDOS',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      debugShowCheckedModeBanner: false,
      home: BlocProvider(
        create: (context) => AuthBloc(),
        child: Screen1(), // Assuming Screen1 is your default login screen
      ),
      routes: {
        '/screen1': (context) => Screen1(),
        '/screen2': (context) => Screen2(),
        '/screen3': (context) => Screen3(),
        '/doctor_screen/doctor_screen1': (context) => DoctorScreen1(),
        '/doctor_screen/doctor_screen2': (context) => DoctorScreen2(),
        '/patient_screens/patient_screen1': (context) => PatientScreen1(),
      },
    );
  }
}
