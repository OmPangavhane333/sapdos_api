import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sapdos/features/presentation/widgets/doctor_card.dart';
import 'package:sapdos/models/doctor.dart';
import 'package:sapdos/models/patient_details_model.dart';
import 'package:sapdos/application/bloc/patient_bloc.dart';

class PatientScreen1 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => PatientBloc()..fetchData(),
      child: PatientScreenContent(),
    );
  }
}

class PatientScreenContent extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('SAPDOS'),
        actions: <Widget>[
          BlocBuilder<PatientBloc, PatientState>(
            builder: (context, state) {
              if (state is PatientLoaded) {
                String avatarUrl = state.data['user']['avatar'] ?? '';
                return CircleAvatar(
                  backgroundImage: NetworkImage(avatarUrl),
                  radius: 20,
                );
              } else {
                return CircleAvatar(
                  backgroundColor: Colors.grey[200],
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
        child: BlocBuilder<PatientBloc, PatientState>(
          builder: (context, state) {
            if (state is PatientLoading) {
              return Center(child: CircularProgressIndicator());
            } else if (state is PatientError) {
              return Center(child: Text('Error: ${state.message}'));
            } else if (state is PatientLoaded) {
              String greeting = state.data['user']['greeting'] ?? 'Hello';
              String patientName = state.patientDetails?.name ?? 'Patient';

              List<Doctor> doctors = state.data['doctors'];

              double screenWidth = MediaQuery.of(context).size.width;
              bool isMobile = screenWidth < 600;
              double cardWidth = isMobile
                  ? (screenWidth / 2) - 24
                  : (screenWidth / 4) - 24;

              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    '$greeting $patientName',
                    style: TextStyle(
                      fontSize: 32,
                      fontWeight: FontWeight.bold,
                    ),
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
                            price: doctor.price,
                          ),
                        ),
                      );
                    }).toList(),
                  ),
                ],
              );
            } else {
              return Center(child: Text('Unexpected state'));
            }
          },
        ),
      ),
    );
  }
}
