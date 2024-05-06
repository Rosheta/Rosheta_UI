// ignore_for_file: library_private_types_in_public_api, avoid_print, file_names

import 'dart:typed_data';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:rosheta_ui/Views/chat/friends_screen.dart';
import 'package:rosheta_ui/Views/patient_medical_data/show_file_screen.dart';
import 'package:rosheta_ui/drawer/drawers.dart';
import 'package:rosheta_ui/generated/l10n.dart';
import 'package:rosheta_ui/models/doctors/MidicalData_model.dart';
import 'package:rosheta_ui/models/patient_medical_data/Appointment_model.dart';
import 'package:rosheta_ui/models/patient_medical_data/Chronic_model.dart';
import 'package:rosheta_ui/models/patient_medical_data/attachment_model.dart';
import 'package:rosheta_ui/services/doctors/DoctorData_service.dart';
import 'package:rosheta_ui/services/doctors/currentAppointment_service.dart';
import 'package:rosheta_ui/services/patient_medical_data/give_access_service.dart';

import '../search/search_screen.dart'; // Import your ChronicDiseaseApi service

class DoctorView extends StatefulWidget {
  const DoctorView({super.key});

  @override
  _DoctorViewState createState() => _DoctorViewState();
}

class _DoctorViewState extends State<DoctorView> {
  late Future<MedicalData> _medicalData;
  late String token;

  @override
  void initState() {
    super.initState();
  }

  Future<MedicalData> _fetchChronicDiseases(String token) async {
    try {
      DoctorDataApi midicalData = DoctorDataApi();
      return await midicalData.fetchDoctorData(token);
    } catch (e) {
      throw Exception('Failed to fetch chronic diseases');
    }
  }

  @override
  Widget build(BuildContext context) {
    final message = ModalRoute.of(context)!.settings.arguments as RemoteMessage;
    token = message.data["dataAccessToken"];
    _medicalData = _fetchChronicDiseases(token);
    return DefaultTabController(
      length: 4, // Number of tabs
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
                  S.of(context).CurrentAppointment,
                  style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                      color: Colors.black54),
                ),
              ),
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
            PrescriptionAndNotesScreen(
              token: token,
            ),
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
                              disease.date,
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
                padding:
                    const EdgeInsets.symmetric(vertical: 0.0, horizontal: 5.0),
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
                                    title: getTitle(S.of(context).prescription),
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
                                          visualDensity: const VisualDensity(
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
                                    ),
                                  ),
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

class PrescriptionAndNotesScreen extends StatefulWidget {
  final String token;
  const PrescriptionAndNotesScreen({super.key, required this.token});

  @override
  _PrescriptionAndNotesScreenState createState() =>
      _PrescriptionAndNotesScreenState();
}

class _PrescriptionAndNotesScreenState
    extends State<PrescriptionAndNotesScreen> {
  TextEditingController prescriptionController = TextEditingController();
  TextEditingController notesController = TextEditingController();
  List<TextEditingController> diseaseControllers = [];
  List<TextEditingController> notesDiseaseControllers = [];
  List<Map<String, String>> chronicDiseases = [];

  @override
  void initState() {
    super.initState();
    // Initialize the lists with empty controllers
    diseaseControllers.add(TextEditingController());
    notesDiseaseControllers.add(TextEditingController());
  }

  void addChronicDisease() {
    setState(() {
      // Create new TextEditingController instances for the new disease
      TextEditingController newDiseaseController = TextEditingController();
      TextEditingController newNotesController = TextEditingController();

      // Add the new controllers to the lists
      diseaseControllers.add(newDiseaseController);
      notesDiseaseControllers.add(newNotesController);

      chronicDiseases.add({
        'disease': newDiseaseController.text,
        'notes': newNotesController.text,
      });
    });
  }

  void saveData() {
    setState(() {
      print('Prescription: ${prescriptionController.text}');
      print('Notes: ${notesController.text}');
      print('Chronic Diseases:');
      for (int i = 0; i < chronicDiseases.length; i++) {
        print(
            'Disease: ${diseaseControllers[i].text}, Notes: ${notesDiseaseControllers[i].text}');
      }
    });

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(S.of(context).save),
          content: Text(S.of(context).saveAndLeaveQ),
          actions: <Widget>[
            TextButton(
              onPressed: () async {
                SendAppointment sendAppointment = SendAppointment();
                // Call the sendAppointment method and pass prescription, note, and chronicDiseases as parameters
                bool success = await sendAppointment.sendAppointment(
                  prescription: prescriptionController.text,
                  note: notesController.text,
                  chronicDiseases: chronicDiseases,
                );

                if (success) {
                  // Show success message or navigate to another screen
                  print('Appointment sent successfully!');
                } else {
                  // Show error message
                  print('Failed to send appointment!');
                }
                Navigator.of(context).pop();
              },
              child: Text(S.of(context).Cancel),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                // Perform save operation here
              },
              child: Text(S.of(context).save),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            getTitle(S.of(context).prescription),
            TextFormField(
              controller: prescriptionController,
              decoration: const InputDecoration(),
              keyboardType: TextInputType.multiline,
              maxLines: null,
              textInputAction: TextInputAction.newline,
            ),
            const SizedBox(height: 16.0),
            getTitle(S.of(context).Notes),
            TextFormField(
              controller: notesController,
              decoration: const InputDecoration(),
              keyboardType: TextInputType.multiline,
              maxLines: null,
              textInputAction: TextInputAction.newline,
            ),
            const SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: addChronicDisease,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(
                    Icons.add_circle,
                    size: 25,
                    color: Colors.black87,
                  ), // This adds the "+" icon
                  const SizedBox(
                      width:
                          5), // Optional: Adds some space between the icon and the text
                  Text(
                    S.of(context).AddChronicDisease,
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.black87,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16.0),
            Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: chronicDiseases.asMap().entries.map((entry) {
                final index = entry.key;
                return Container(
                  padding: const EdgeInsets.all(16.0),
                  margin: const EdgeInsets.symmetric(vertical: 8.0),
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.black),
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      getDis(S.of(context).ChronicDis),
                      TextFormField(
                        controller: diseaseControllers[index],
                        decoration: const InputDecoration(),
                        keyboardType: TextInputType.multiline,
                        maxLines: null,
                        textInputAction: TextInputAction.newline,
                      ),
                      const SizedBox(height: 8.0),
                      getDis(S.of(context).Notes),
                      TextFormField(
                        controller: notesDiseaseControllers[index],
                        decoration: const InputDecoration(),
                        keyboardType: TextInputType.multiline,
                        maxLines: null,
                        textInputAction: TextInputAction.newline,
                      ),
                    ],
                  ),
                );
              }).toList(),
            ),
            ElevatedButton(
              onPressed: saveData,
              style: ElevatedButton.styleFrom(backgroundColor: Colors.green),
              child: Text(
                S.of(context).save,
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
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
          subtitle: Text(time),
        ),
      ),
    );
  }
}
