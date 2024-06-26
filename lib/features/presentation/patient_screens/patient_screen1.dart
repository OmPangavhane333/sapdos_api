import 'package:flutter/material.dart';
import 'package:sapdos/features/presentation/widgets/doctor_card.dart';
import 'package:sapdos/models/doctor.dart';
import 'package:sapdos/models/patient_details_model.dart';

import 'dart:convert';
import 'package:http/http.dart' as http;

class PatientScreen1 extends StatefulWidget {
  @override
  _PatientScreen1State createState() => _PatientScreen1State();
}

class _PatientScreen1State extends State<PatientScreen1> {
  late Future<Map<String, dynamic>> _futureData;
  late Future<PatientDetailsModel?> _futurePatient;

  // Simulating authenticated user ID (replace with actual implementation)
  String userId = '6b8fcda6-5c96-4ea6-8351-527cae571f59';

  @override
  void initState() {
    super.initState();
    _futureData = fetchDoctorsFromJson();
    _futurePatient = getPatientByUId(userId);
  }

  Future<Map<String, dynamic>> fetchDoctorsFromJson() async {
    String jsonString = await DefaultAssetBundle.of(context)
        .loadString('assets/doctors_list.json');
    Map<String, dynamic> jsonData = json.decode(jsonString);
    List<dynamic> doctorListJson = jsonData['doctorsList'];

    List<Doctor> doctors = doctorListJson
        .map((json) => Doctor(
              name: json['doctorName'] ?? 'Unknown Doctor',
              specialization: json['specialization'] ?? 'Unknown Specialization',
              rating: 0.0,
              doctorImage: json['doctorImage'] ?? '',
              appointmentIcon: json['appointmentIcon'] ?? '',
              price: (json['price'] ?? 0).toDouble(),
            ))
        .toList();

    return {'user': jsonData['user'] ?? {}, 'doctors': doctors};
  }

  Future<PatientDetailsModel?> getPatientByUId(String id) async {
    String base_url = "https://sapdos-api-v2.azurewebsites.net";

    try {
      final response = await http.get(Uri.parse("$base_url/api/Patient/GetPatientByUId?PatientUId=$id"));
      if (response.statusCode == 200) {
        dynamic jsonResponse = json.decode(response.body);
        if (jsonResponse is List) {
          jsonResponse = jsonResponse.first;
        }
        return PatientDetailsModel.fromJson(jsonResponse);
      } else {
        print('Error: status code ${response.statusCode}');
        throw Exception('Failed to fetch patient: ${response.reasonPhrase}');
      }
    } catch (e) {
      print("Error getPatientByUId: $e");
      throw Exception("Failed to fetch patient");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('SAPDOS'),
        actions: <Widget>[
          FutureBuilder<Map<String, dynamic>>(
            future: _futureData,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return CircleAvatar(
                  backgroundColor: Colors.grey[200],
                  radius: 20,
                );
              } else if (snapshot.hasError) {
                return Icon(Icons.error);
              } else {
                String avatarUrl = snapshot.data!['user']['avatar'] ?? '';
                return CircleAvatar(
                  backgroundImage: NetworkImage(avatarUrl),
                  radius: 20,
                );
              }
            },
          ),
        ],
      ),
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
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: FutureBuilder<Map<String, dynamic>>(
            future: _futureData,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(child: CircularProgressIndicator());
              } else if (snapshot.hasError) {
                return Center(child: Text('Error: ${snapshot.error}'));
              } else if (!snapshot.hasData || snapshot.data!['doctors'].isEmpty) {
                return Center(child: Text('No doctors available'));
              }

              String greeting = snapshot.data!['user']['greeting'] ?? 'Hello';
              String name = snapshot.data!['user']['name'] ?? 'User';
              List<Doctor> doctors = snapshot.data!['doctors'];
              double screenWidth = MediaQuery.of(context).size.width;
              bool isMobile = screenWidth < 600;
              double cardWidth = isMobile
                  ? (screenWidth / 2) - 24
                  : (screenWidth / 4) - 24;

              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  FutureBuilder<PatientDetailsModel?>(
                    future: _futurePatient,
                    builder: (context, patientSnapshot) {
                      if (patientSnapshot.connectionState == ConnectionState.waiting) {
                        return CircularProgressIndicator();
                      } else if (patientSnapshot.hasError) {
                        return Text('Error: ${patientSnapshot.error}');
                      } else if (!patientSnapshot.hasData || patientSnapshot.data == null) {
                        return Text('Patient details not available');
                      }

                      String patientName = patientSnapshot.data!.name;

                      return Text(
                        '$greeting $patientName',
                        style: TextStyle(
                          fontSize: 32,
                          fontWeight: FontWeight.bold,
                        ),
                      );
                    },
                  ),
                  SizedBox(height: 20),
                  Container(
                    decoration: BoxDecoration(
                      color: Color(0xFF13235A),
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                    padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Doctor's List",
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                        PopupMenuButton<String>(
                          icon: Icon(Icons.filter_list, color: Colors.white),
                          onSelected: (value) {
                            // Implement filter logic here
                          },
                          itemBuilder: (BuildContext context) {
                            return {'Filter by ratings', 'Filter by name'}
                                .map((String choice) {
                                  return PopupMenuItem<String>(
                                    value: choice,
                                    child: Text(choice),
                                  );
                                }).toList();
                          },
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 20),
                  Wrap(
                    spacing: 8.0,
                    runSpacing: 8.0,
                    children: doctors.map((doctor) {
                      return SizedBox(
                        width: cardWidth,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 4.0),
                          child: DoctorCard(
                            doctor: doctor,
                            appointmentIcon: doctor.appointmentIcon,
                            price: doctor!.price,
                          ),
                        ),
                      );
                    }).toList(),
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}
