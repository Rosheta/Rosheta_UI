// ignore_for_file: library_private_types_in_public_api, avoid_print, file_names

import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:rosheta_ui/Views/patient_medical_data/show_file_screen.dart';
import 'package:rosheta_ui/drawer/drawers.dart';
import 'package:rosheta_ui/generated/l10n.dart';
import 'package:rosheta_ui/models/doctors/MedicalData_model.dart';
import 'package:rosheta_ui/models/patient_medical_data/Appointment_model.dart';
import 'package:rosheta_ui/models/patient_medical_data/Chronic_model.dart';
import 'package:rosheta_ui/models/patient_medical_data/attachment_model.dart';
import 'package:rosheta_ui/services/doctors/doctor_data_service.dart';
import 'package:rosheta_ui/services/patient_medical_data/give_access_service.dart';

class EmergencyView extends StatefulWidget {
  final String token; // Define a property to hold the user object
  const EmergencyView({super.key, required this.token});

  @override
  _EmergencyViewState createState() => _EmergencyViewState();
}

class _EmergencyViewState extends State<EmergencyView> {
  late Future<MedicalData> _medicalData;
  @override
  void initState() {
    super.initState();
  }

  Future<MedicalData> _fetchData(String token) async {
    try {
      DoctorDataApi midicalData = DoctorDataApi();
      return await midicalData.fetchDoctorData(token);
    } catch (e) {
      MedicalData medicalData = MedicalData(
        appointments: [],
        chronicDiseases: [],
        attachments: [],
      );
      return medicalData;
    }
  }

  @override
  Widget build(BuildContext context) {
    String token = widget.token;
    _medicalData = _fetchData(token);
    return DefaultTabController(
      length: 3, // Number of tabs
      child: Scaffold(
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
          bottom: TabBar(
            isScrollable: true,
            tabs: [
              Tab(
                child: Text(
                  S.of(context).Chronic,
                  style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                      color: Colors.black54),
                ),
              ),
              Tab(
                child: Text(
                  S.of(context).Appointment,
                  style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                      color: Colors.black54),
                ),
              ),
              Tab(
                child: Text(
                  S.of(context).Attachments,
                  style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                      color: Colors.black54),
                ),
              ),
            ],
          ),
        ),
        drawer: select_drawer(context),
        body: TabBarView(
          children: [
            // First tab content

            // Second tab content
            DoctorChronicDiseaseListWidget(medicalDataFeture: _medicalData),
            // Third tab content

            DoctorAppointmentListWidget(medicalDataFeture: _medicalData),

            // Fourth tab content
            DoctorAttachmentsListWidget(
              medicalDataFeture: _medicalData,
              token: token,
            ),
          ],
        ),
      ),
    );
  }
}

class DoctorChronicDiseaseListWidget extends StatelessWidget {
  final Future<MedicalData> medicalDataFeture;

  const DoctorChronicDiseaseListWidget(
      {super.key, required this.medicalDataFeture});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<MedicalData>(
      future: medicalDataFeture,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        } else {
          List<ChronicDisease> chronicDiseases = snapshot.data!.chronicDiseases;
          return ListView.builder(
            itemCount: chronicDiseases.length,
            itemBuilder: (context, index) {
              ChronicDisease disease = chronicDiseases[index];
              return Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 0.0, horizontal: 5.0),
                child: Card(
                  elevation: 0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.cyan,
                      borderRadius: BorderRadius.circular(
                          20.0), // Set the border radius for circular edges
                    ),
                    child: Theme(
                      data: ThemeData()
                          .copyWith(dividerColor: Colors.transparent),
                      child: ExpansionTile(
                        tilePadding: const EdgeInsets.symmetric(
                            vertical: 0.0, horizontal: 8.0),
                        title: Text(
                          disease.name,
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
                                horizontal: 0, vertical: -4),
                            title: getChronicTitle(S.of(context).assignDate),
                            subtitle: Text(
                              disease.date.substring(0, 10),
                              style: const TextStyle(
                                  color: Colors.black, fontSize: 20),
                            ),
                          ),
                          ListTile(
                            visualDensity: const VisualDensity(
                                horizontal: 0, vertical: -4),
                            title: getChronicTitle(S.of(context).Notes),
                            subtitle: Text(
                              disease.notes,
                              style: const TextStyle(
                                  color: Colors.black, fontSize: 20),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              );
            },
          );
        }
      },
    );
  }

  Row getChronicTitle(String title) {
    return Row(
      mainAxisSize:
          MainAxisSize.min, // Ensure the Row takes minimum space required
      children: [
        Container(
          padding: const EdgeInsets.symmetric(
              vertical: 4, horizontal: 8), // Padding around the text
          decoration: BoxDecoration(
            color: const Color.fromARGB(
                255, 13, 122, 134), // Background color of the rectangle
            borderRadius: BorderRadius.circular(
                10), // Border radius to make it rectangular
          ),
          child: Text(
            title,
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
}

class DoctorAppointmentListWidget extends StatelessWidget {
  final Future<MedicalData> medicalDataFeture;

  const DoctorAppointmentListWidget(
      {super.key, required this.medicalDataFeture});
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<MedicalData>(
      future: medicalDataFeture,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        } else {
          List<Appointment> appointments = snapshot.data!.appointments;

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
                                  "${appointment.doctorName}\n${appointment.date.substring(0, 10)}",
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
                                    title: getTitle(S.of(context).examination2),
                                    subtitle: Text(
                                      appointment.examination,
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
                                    title: getTitle(S.of(context).Diagnosis),
                                    subtitle: Text(
                                      appointment.diagnosis,
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
                                    title: getTitle(S.of(context).prescription),
                                    subtitle: Text(
                                      appointment.prescriptions,
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
                                            visualDensity: const VisualDensity(
                                              horizontal: 0,
                                              vertical: -4,
                                            ),
                                            title: getDis(disease!.name),
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
    );
  }
}

Row getDis(T) {
  return Row(
    mainAxisSize: MainAxisSize.min,
    children: [
      Container(
        padding: const EdgeInsets.symmetric(vertical: 0, horizontal: 15),
        decoration: BoxDecoration(
          color: const Color.fromARGB(255, 13, 122, 134),
          borderRadius: BorderRadius.circular(10),
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

Row getTitle(T) {
  return Row(
    mainAxisSize: MainAxisSize.min,
    children: [
      Container(
        padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
        decoration: BoxDecoration(
          color: const Color.fromARGB(255, 13, 122, 134),
          borderRadius: BorderRadius.circular(10),
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

class DoctorAttachmentsListWidget extends StatefulWidget {
  final Future<MedicalData> medicalDataFeture;
  final String token;

  const DoctorAttachmentsListWidget(
      {super.key, required this.medicalDataFeture, required this.token});

  @override
  _DoctorAttachmentsListWidgetState createState() =>
      _DoctorAttachmentsListWidgetState();
}

class _DoctorAttachmentsListWidgetState
    extends State<DoctorAttachmentsListWidget> {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<MedicalData>(
      future: widget.medicalDataFeture,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        } else {
          List<Attachment> attachments = snapshot.data!.attachments;
          return Padding(
            padding: const EdgeInsets.all(20.0),
            child: Container(
              height: MediaQuery.of(context).size.height,
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ListView.builder(
                      shrinkWrap: true,
                      itemCount: attachments.length,
                      itemBuilder: (context, index) {
                        Attachment attach = attachments[index];
                        return fileCard(
                          fileHash: attach.fileHash!,
                          name: attach.name!,
                          ext: attach.ext!,
                          time: attach.time!,
                          index: index,
                          context: context,
                        );
                      },
                    ),
                  ],
                ),
              ),
            ),
          );
        }
      },
    );
  }

  Widget fileCard({
    required String fileHash,
    required String name,
    required String ext,
    required String time,
    required int index,
    required BuildContext context,
  }) {
    IconData iconData;
    switch (ext.toLowerCase()) {
      case '.pdf':
        iconData = Icons.picture_as_pdf;
        break;
      case '.png':
      case '.jpeg':
      case '.jpg':
        iconData = Icons.image;
        break;
      default:
        iconData = Icons.insert_drive_file;
        break;
    }

    return InkWell(
      onTap: () async {
        GiveAccessApi attachmentApi = GiveAccessApi();
        Uint8List tmp = await attachmentApi.getAttachment(
            fileHash, widget.token /*write sharedtoken here*/
            );
        Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => ShowFileScreen(serverData: tmp, ext: ext)),
        );
      },
      child: Card(
        child: ListTile(
          leading: Icon(iconData),
          title: Text(
            '$name$ext',
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
          subtitle: Text(time.substring(0,10)),
        ),
      ),
    );
  }
}
