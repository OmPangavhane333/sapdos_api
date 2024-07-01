import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sapdos/features/presentation/payment_screens/payment_screen1.dart';
import 'package:sapdos/features/presentation/widgets/doctor_card.dart';
import 'package:sapdos/models/doctor.dart';
import 'package:sapdos/application/bloc/patient_bloc.dart';
import 'package:intl/intl.dart';

class PatientScreen2 extends StatelessWidget {
  final Doctor doctor;

  PatientScreen2({required this.doctor});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => PatientScreenBloc(doctor),
      child: PatientScreen2Content(),
    );
  }
}

class PatientScreen2Content extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final bloc = BlocProvider.of<PatientScreenBloc>(context);

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: Text(bloc.doctor.name),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                CircleAvatar(
                  backgroundImage: NetworkImage('https://www.gravatar.com/avatar/2c7d99fe281ecd3bcd65ab915bac6dd5?s=250'),
                  radius: 60,
                ),
                SizedBox(width: 20),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Dr.${bloc.doctor.name}',
                            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                          ),
                          Row(
                            children: [
                              Icon(Icons.star, color: Colors.orange, size: 20),
                              Icon(Icons.star, color: Colors.orange, size: 20),
                              Icon(Icons.star, color: Colors.orange, size: 20),
                              Icon(Icons.star_half, color: Colors.orange, size: 20),
                              Icon(Icons.star_border, size: 20),
                              SizedBox(width: 5),
                              Text(
                                '512',
                                style: TextStyle(fontSize: 18),
                              ),
                              SizedBox(width: 10),
                              Icon(Icons.calendar_today, size: 20),
                              SizedBox(width: 5),
                              Text(
                                '5 Years',
                                style: TextStyle(fontSize: 18),
                              ),
                            ],
                          ),
                        ],
                      ),
                      SizedBox(height: 10),
                      Row(
                        children: [
                          Icon(Icons.medical_services, size: 18),
                          SizedBox(width: 5),
                          Text(
                            bloc.doctor.specialization,
                            style: TextStyle(fontSize: 16),
                          ),
                        ],
                      ),
                      SizedBox(height: 5),
                      Row(
                        children: [
                          Icon(Icons.school, size: 18),
                          SizedBox(width: 5),
                          Text(
                            'BDS, DDS',
                            style: TextStyle(fontSize: 16),
                          ),
                        ],
                      ),
                      SizedBox(height: 10),
                      Text(
                        'Description',
                        style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                      ),
                      SizedBox(height: 5),
                      Text(
                        'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur.',
                        style: TextStyle(fontSize: 16),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            SizedBox(height: 20),
            Container(
              decoration: BoxDecoration(
                color: Color(0xFF13235A),
                borderRadius: BorderRadius.circular(10),
              ),
              padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Icon(Icons.access_time, color: Colors.white),
                      SizedBox(width: 5),
                      Text(
                        'Available Slots',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                  IconButton(
                    icon: Icon(Icons.calendar_today, color: Colors.white),
                    onPressed: () {
                      _selectDate(context, bloc);
                    },
                  ),
                ],
              ),
            ),
            SizedBox(height: 10),
            Text(
              'Selected Date: ${bloc.getFormattedDate()}',
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 10),
            Wrap(
              spacing: 10,
              runSpacing: 10,
              children: List.generate(6, (index) {
                return ChoiceChip(
                  label: Text('10:00 - 10:15 AM'),
                  selected: index == 0,
                  onSelected: (selected) {},
                );
              }),
            ),
            SizedBox(height: 50),
            Center(
              child: ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => PaymentScreen1()),
                  );
                },
                child: Text('Book Appointment'),
                style: ElevatedButton.styleFrom(
                  primary: Color(0xFF13235A),
                  onPrimary: Colors.white,
                  padding: EdgeInsets.symmetric(horizontal: 40, vertical: 15),
                  textStyle: TextStyle(fontSize: 18),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _selectDate(BuildContext context, PatientScreenBloc bloc) async {
    DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2020),
      lastDate: DateTime(2025),
    );
    if (pickedDate != null) {
      bloc.add(SelectDateEvent(pickedDate));
    }
  }
}
