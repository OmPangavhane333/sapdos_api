import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http; 
import 'package:sapdos/features/presentation/doctor_screen/model/doctor_model.dart';
import 'package:sapdos/features/presentation/doctor_screen/widgets/appointment_card.dart';
import 'package:sapdos/features/presentation/doctor_screen/widgets/appointment_list.dart';
import 'package:sapdos/features/presentation/doctor_screen/widgets/calendar_screen.dart';
import 'package:sapdos/services/api_service.dart'; 

String base_url = "https://sapdos-api-v2.azurewebsites.net";

Future<List<DoctorModel>> getAllDoctor() async {
  try {
    final response = await http.get(Uri.parse('$base_url/api/Patient/GetAllUser?Role=doctor'));
    if (response.statusCode == 200) {
      List<dynamic> jsonList = json.decode(response.body);
      List<DoctorModel> doctors = jsonList.map((json) => DoctorModel.fromJson(json)).toList();
      return doctors;
    } else {
      return [];
    }
  } catch (e) {
    print('Error in getAllDoctor: $e');
    throw Exception('Failed to fetch doctors');
  }
}

Future<DoctorModel> getDoctorByUId(String id) async {
  try {
    final response = await http.get(Uri.parse('$base_url/api/Patient/GetDoctorByUId?DoctorUId=$id'));
    if (response.statusCode == 200) {
      dynamic jsonResponse = json.decode(response.body);
      if (jsonResponse is List) {
        jsonResponse = jsonResponse.first;
      }
      DoctorModel doctor = DoctorModel.fromJson(jsonResponse);
      return doctor;
    } else {
      print('Error: status code ${response.statusCode}');
      throw Exception('Failed to fetch doctor');
    }
  } catch (e) {
    print('Error: $e');
    throw Exception('Failed to fetch doctor');
  }
}

class DoctorScreen1 extends StatefulWidget {
  final String userUid;

  DoctorScreen1({required this.userUid});

  @override
  _DoctorScreen1State createState() => _DoctorScreen1State();
}

class _DoctorScreen1State extends State<DoctorScreen1> {
  DoctorModel? doctor;
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    fetchDoctor(widget.userUid);
  }

  Future<void> fetchDoctor(String uid) async {
    try {
      DoctorModel fetchedDoctor = await getDoctorByUId(uid);
      setState(() {
        doctor = fetchedDoctor;
        isLoading = false;
      });
    } catch (e) {
      print('Error fetching doctor: $e');
      setState(() {
        isLoading = false;
      });
      
    }
  }

  @override
  Widget build(BuildContext context) {
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
              backgroundImage: NetworkImage('https://www.gravatar.com/avatar/2c7d99fe281ecd3bcd65ab915bac6dd5?s=250'),
            ),
          ),
        ],
      ),
      body: isLoading
          ? Center(child: CircularProgressIndicator())
          : Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  GestureDetector(
                    onTap: () {
                      Navigator.pushNamed(context, '/doctor_screen/doctor_screen2');
                    },
                    child: Text(
                      'Hello!\nDr. ${doctor?.name}',
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
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => CalendarScreen(
                              selectedDate: selectedDate,
                              appointments: [],
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
                            'Wednesday, March 7',
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
                    child: AppointmentList(),
                  ),
                ],
              ),
            ),
    );
  }
}
