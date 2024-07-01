import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sapdos/application/bloc/auth_bloc.dart';
import 'package:sapdos/application/bloc/patient_bloc.dart';
import 'package:sapdos/application/login_bloc/login_bloc.dart';
import 'package:sapdos/features/presentation/doctor_screen/doctor_screen1.dart';
import 'package:sapdos/features/presentation/doctor_screen/doctor_screen2.dart';
import 'package:sapdos/features/presentation/login_screens/login_screen1.dart';
import 'package:sapdos/features/presentation/login_screens/login_screen2.dart';
import 'package:sapdos/features/presentation/login_screens/signup/bloc/registration_bloc.dart';
import 'package:sapdos/features/presentation/login_screens/signup/signup.dart';
import 'package:sapdos/features/presentation/patient_screens/patient_screen1.dart';
import 'package:sapdos/features/presentation/patient_screens/patient_screen2.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => AuthBloc()),
        BlocProvider(create: (context) => LoginBloc()),
        BlocProvider(create: (context) => RegistrationBloc()),
        BlocProvider(create: (context) => PatientBloc()),
        BlocProvider(create: (context) => PatientScreenBloc()),
        BlocProvider(create: (context) => DoctorScreenBloc()),
      ],
      child: MaterialApp(
        title: 'SAPDOS',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        debugShowCheckedModeBanner: false,
        home: LoginScreen1(),
        routes: {
          '/screen1': (context) => LoginScreen1(),
          '/screen2': (context) => Screen2(),
          '/screen3': (context) => Screen3(),
          '/doctor_screen/doctor_screen1': (context) => DoctorScreen1(
            userUid: '1dbaa439-a8e0-4f7b-93c4-191d11e537c1',
          ),
          '/doctor_screen/doctor_screen2': (context) => DoctorScreen2(),
          '/patient_screens/patient_screen1': (context) => PatientScreen1(),
          '/patient_screens/patient_screen2': (context) => BlocProvider(
            create: (context) => PatientBloc(),
            child: PatientScreen2(doctor: Doctor()),
          ),
        },
      ),
    );
  }
}
