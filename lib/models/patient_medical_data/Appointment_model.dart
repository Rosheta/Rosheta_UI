import 'package:rosheta_ui/models/patient_medical_data/Chronic_model.dart';

class Appointment {
  final String name;
  final String date;
  final String doctorName;
  final String examination;
  final String diagnosis;
  final String prescriptions;
  final String notes;
  final ChronicDiseaseList chronicDiseases;

  Appointment({
    required this.name,
    required this.date,
    required this.doctorName,
    required this.examination,
    required this.diagnosis,
    required this.prescriptions,
    required this.notes,
    required this.chronicDiseases,
  });

  factory Appointment.fromJson(Map<String, dynamic> json) {
    return Appointment(
      name: json['Name'],
      date: json['Date'],
      doctorName: json['DoctorId'],
      examination: json['Prescription']['Examination'],
      diagnosis: json['Prescription']['Diagnosis'],
      prescriptions: json['Prescription']['Prescriptions'],
      notes: json['Notes'],
      chronicDiseases: ChronicDiseaseList.fromJson(json['ChronicDiseases']),
    );
  }
}
