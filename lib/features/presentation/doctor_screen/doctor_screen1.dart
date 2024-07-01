import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sapdos/features/presentation/doctor_screen/model/doctor_model.dart';
import 'package:sapdos/features/presentation/doctor_screen/widgets/appointment_card.dart';
import 'package:sapdos/features/presentation/doctor_screen/widgets/appointment_list.dart';
import 'package:sapdos/features/presentation/doctor_screen/widgets/calendar_screen.dart';
import 'package:sapdos/application/doctor_bloc.dart'; 

class DoctorScreen1 extends StatefulWidget {
  final String userUid;

  DoctorScreen1({required this.userUid});

  @override
  _DoctorScreen1State createState() => _DoctorScreen1State();
}

class _DoctorScreen1State extends State<DoctorScreen1> {
  late DoctorBloc doctorBloc;

  @override
  void initState() {
    super.initState();
    doctorBloc = DoctorBloc();
    doctorBloc.fetchDoctor(widget.userUid);
  }

  @override
  void dispose() {
    doctorBloc.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<DoctorBloc, DoctorState>(
      bloc: doctorBloc,
      builder: (context, state) {
        if (state is DoctorLoading) {
          return Scaffold(
            appBar: AppBar(
              title: Text('SAPDOS'),
            ),
            body: Center(child: CircularProgressIndicator()),
          );
        } else if (state is DoctorLoaded) {
          DoctorModel doctor = state.doctor;
          return Scaffold(
            drawer: SizedBox(
              width: 200,
              child: Drawer(
                child: ListView(
                  padding: EdgeInsets.zero,
                  children: <Widget>[
                    DrawerHeader(
                      decoration: BoxDecoration(
                        color: Color(0xFF13235A),
                      ),
                      child: Text(
                        'SAPDOS',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 24,
                        ),
                      ),
                    ),
                    ListTile(
                      leading: Icon(Icons.category),
                      title: Text('Categories'),
                    ),
                    ListTile(
                      leading: Icon(Icons.calendar_today),
                      title: Text('Appointment'),
                      onTap: () {
                        Navigator.pushNamed(context, '/calendar_screen');
                      },
                    ),
                    ListTile(
                      leading: Icon(Icons.chat),
                      title: Text('Chat'),
                    ),
                    ListTile(
                      leading: Icon(Icons.settings),
                      title: Text('Settings'),
                    ),
                    ListTile(
                      leading: Icon(Icons.logout),
                      title: Text('Logout'),
                      onTap: () {
                        Navigator.pushNamedAndRemoveUntil(
                          context,
                          '/screen1',
                          (Route<dynamic> route) => false,
                        );
                      },
                    ),
                  ],
                ),
              ),
            ),
            appBar: AppBar(
              title: Text('SAPDOS'),
              actions: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(right: 16.0),
                  child: CircleAvatar(
                    radius: 20,
                    backgroundImage: NetworkImage(
                        'https://www.gravatar.com/avatar/2c7d99fe281ecd3bcd65ab915bac6dd5?s=250'),
                  ),
                ),
              ],
            ),
            body: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  GestureDetector(
                    onTap: () {
                      Navigator.pushNamed(context, '/doctor_screen/doctor_screen2');
                    },
                    child: Text(
                      'Hello!\nDr. ${doctor.name}',
                      style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                    ),
                  ),
                  SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      Flexible(
                        flex: 1,
                        child: AppointmentCard('Pending Appointments', 19, 40),
                      ),
                      SizedBox(width: 10),
                      Flexible(
                        flex: 1,
                        child: AppointmentCard('Completed Appointments', 21, 40),
                      ),
                    ],
                  ),
                  SizedBox(height: 20),
                  GestureDetector(
                    onTap: () async {
                      DateTime? selectedDate = await showDatePicker(
                        context: context,
                        initialDate: DateTime.now(),
                        firstDate: DateTime(2000),
                        lastDate: DateTime(2100),
                      );
                      if (selectedDate != null) {
                        // Handle logic to fetch available slots
                        // doctorBloc.fetchAvailableSlots(widget.userUid, selectedDate.toIso8601String());
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => CalendarScreen(
                              selectedDate: selectedDate,
                              appointments: [], // Replace with actual data
                            ),
                          ),
                        );
                      }
                    },
                    child: Container(
                      padding: EdgeInsets.all(8.0),
                      decoration: BoxDecoration(
                        color: Color(0xFF13235A),
                        borderRadius: BorderRadius.circular(4.0),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Wednesday, March 7', // Replace with dynamic date
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                          Icon(
                            Icons.calendar_today,
                            color: Colors.white,
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(height: 10),
                  Expanded(
                    child: AppointmentList(), // Replace with actual list widget
                  ),
                ],
              ),
            ),
          );
        } else if (state is DoctorError) {
          return Scaffold(
            appBar: AppBar(
              title: Text('SAPDOS'),
            ),
            body: Center(
              child: Text('Error: ${state.message}'),
            ),
          );
        } else {
          return Scaffold(
            appBar: AppBar(
              title: Text('SAPDOS'),
            ),
            body: Center(
              child: Text('Unknown state'),
            ),
          );
        }
      },
    );
  }
}
