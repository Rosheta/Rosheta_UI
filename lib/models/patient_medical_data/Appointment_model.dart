import 'package:rosheta_ui/models/patient_medical_data/Chronic_model.dart';
class Appointment {  
  final String name;
  final String date;
  final String doctorName;
  final String prescription;
  final String notes;
  final ChronicDiseaseList chronicDiseases;

  Appointment({
    required this.name,
    required this.date,
    required this.doctorName,
    required this.prescription,
    required this.notes,
    required this.chronicDiseases,
  });
  
  factory Appointment.fromJson(Map<String, dynamic> json) {
    Appointment app = Appointment(
      name: json['Name'],
      date: json['Date'],
      doctorName: json['DoctorId'],
      prescription: json['Prescription'],
      notes: json['Notes'],
      chronicDiseases: ChronicDiseaseList.fromJson(json['ChronicDiseases']),
    );
    return app;
  }
}
