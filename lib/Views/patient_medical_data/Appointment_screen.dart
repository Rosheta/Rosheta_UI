// ignore_for_file: file_names, use_super_parameters, library_private_types_in_public_api

import 'package:flutter/material.dart';
import 'package:rosheta_ui/drawer/drawers.dart';
import 'package:rosheta_ui/generated/l10n.dart';
import 'package:rosheta_ui/models/patient_medical_data/Appointment_model.dart';
import 'package:rosheta_ui/services/patient_medical_data/Appointment_service.dart';

import '../search/search_screen.dart'; // Import your SearchPeople delegate

class AppointmentListScreen extends StatefulWidget {
  const AppointmentListScreen({Key? key}) : super(key: key);

  @override
  _AppointmentListScreenState createState() => _AppointmentListScreenState();
}

class _AppointmentListScreenState extends State<AppointmentListScreen> {
  late Future<List<Appointment>> _appointmentsFuture;

  @override
  void initState() {
    super.initState();
    _appointmentsFuture = _fetchAppointments();
  }

  Future<List<Appointment>> _fetchAppointments() async {
    try {
      AppointmentListApi appointmentApi = AppointmentListApi();
      return await appointmentApi.fetchAppointments();
    } catch (e) {
      throw Exception('Failed to fetch appointments');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.cyan,
        title: Text(
          S.of(context).title,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 25,
            color: Colors.black,
          ),
        ),
        actions: <Widget>[
          IconButton(
            icon: const Icon(Icons.search),
            iconSize: 30,
            color: Colors.black,
            onPressed: () {
              showSearch(
                context: context,
                delegate: SearchPeople(),
              );
            },
          ),
        ],
      ),
      drawer: select_drawer(context),
      body: FutureBuilder<List<Appointment>>(
        future: _appointmentsFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else {
            List<Appointment> appointments = snapshot.data!;

            return ListView.builder(
              itemCount: appointments.length,
              itemBuilder: (context, index) {
                Appointment appointment = appointments[index];
                return Padding(
                  padding: const EdgeInsets.symmetric(
                    vertical: 0.0,
                    horizontal: 5.0,
                  ),
                  child: Column(
                    children: [
                      Card(
                        elevation: 0,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Column(
                          children: [
                            Container(
                              decoration: BoxDecoration(
                                color: Colors.cyan,
                                borderRadius: BorderRadius.circular(20.0),
                              ),
                              child: Theme(
                                data: ThemeData().copyWith(
                                  dividerColor: Colors.transparent,
                                ),
                                child: ExpansionTile(
                                  tilePadding: const EdgeInsets.symmetric(
                                    vertical: 0.0,
                                    horizontal: 8.0,
                                  ),
                                  title: Text(
                                    "${appointment.doctorName}\n${appointment.date}",
                                    style: const TextStyle(
                                      fontSize: 22,
                                      fontWeight: FontWeight.bold,
                                      color: Color.fromARGB(255, 255, 255, 255),
                                    ),
                                  ),
                                  initiallyExpanded: false,
                                  children: [
                                    ListTile(
                                      visualDensity: const VisualDensity(
                                        horizontal: 0,
                                        vertical: -4,
                                      ),
                                      title:
                                          getTitle(S.of(context).prescription),
                                      subtitle: Text(
                                        appointment.prescription,
                                        style: const TextStyle(
                                          color: Colors.black,
                                          fontSize: 20,
                                        ),
                                      ),
                                    ),
                                    ListTile(
                                      visualDensity: const VisualDensity(
                                        horizontal: 0,
                                        vertical: -4,
                                      ),
                                      title: getTitle(S.of(context).Notes),
                                      subtitle: Text(
                                        appointment.notes,
                                        style: const TextStyle(
                                          color: Colors.black,
                                          fontSize: 20,
                                        ),
                                      ),
                                    ),
                                    ListTile(
                                        visualDensity: const VisualDensity(
                                          horizontal: 0,
                                          vertical: -4,
                                        ),
                                        title: getTitle(S.of(context).Chronic),
                                        subtitle: Column(
                                          children: appointment
                                              .chronicDiseases.diseases
                                              .map((disease) {
                                            return ListTile(
                                              visualDensity:
                                                  const VisualDensity(
                                                horizontal: 0,
                                                vertical: -4,
                                              ),
                                              title: getDis(disease.name),
                                              subtitle: Text(
                                                disease.notes,
                                                style: const TextStyle(
                                                  color: Colors.black,
                                                  fontSize: 18,
                                                ),
                                              ),
                                            );
                                          }).toList(),
                                        )),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                );
              },
            );
          }
        },
      ),
    );
  }

  Row getTitle(T) {
    return Row(
      mainAxisSize:
          MainAxisSize.min, // Ensure the Row takes minimum space required
      children: [
        Container(
          padding: const EdgeInsets.symmetric(
              vertical: 0, horizontal: 8), // Padding around the text
          decoration: BoxDecoration(
            color: const Color.fromARGB(
                255, 13, 122, 134), // Background color of the rectangle
            borderRadius: BorderRadius.circular(
                10), // Border radius to make it rectangular
          ),
          child: Text(
            T,
            style: const TextStyle(
              color: Color.fromARGB(255, 255, 254, 255),
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ],
    );
  }

  Row getDis(T) {
    return Row(
      mainAxisSize:
          MainAxisSize.min, // Ensure the Row takes minimum space required
      children: [
        Container(
          padding: const EdgeInsets.symmetric(
              vertical: 0, horizontal: 15), // Padding around the text
          decoration: BoxDecoration(
            color: const Color.fromARGB(
                255, 13, 122, 134), // Background color of the rectangle
            borderRadius: BorderRadius.circular(
                10), // Border radius to make it rectangular
          ),
          child: Text(
            T,
            style: const TextStyle(
              color: Color.fromARGB(255, 255, 254, 255),
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ],
    );
  }
}
