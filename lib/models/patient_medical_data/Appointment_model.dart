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
    return Appointment(
      name: json['name'],
      date: json['date'],
      doctorName: json['doctor_name'],
      prescription: json['prescription'],
      notes: json['notes'],
      chronicDiseases: ChronicDiseaseList.fromJson(json['chronic_diseases']),
    );
  }
}
