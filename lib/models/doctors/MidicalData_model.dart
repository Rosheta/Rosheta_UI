import 'package:rosheta_ui/models/patient_medical_data/Appointment_model.dart';
import 'package:rosheta_ui/models/patient_medical_data/Chronic_model.dart';

// Model class to hold all data including appointments, chronic diseases, and attachments
class MedicalData {
  final List<Appointment> appointments;
  final List<ChronicDisease> chronicDiseases;
  final List<String> attachments;

  MedicalData({
    required this.appointments,
    required this.chronicDiseases,
    required this.attachments,
  });

  factory MedicalData.fromJson(Map<String, dynamic> jsonData) {
    List<Appointment> appointments = (jsonData['appointments'] as List)
        .map((appointmentJson) =>
            Appointment.fromJson(appointmentJson))
        .toList();

    List<ChronicDisease> chronicDiseases = (jsonData['chronic_diseases'] as List)
        .map((chronicDiseaseJson) =>
            ChronicDisease.fromJson(chronicDiseaseJson))
        .toList();

    List<String> attachments = List<String>.from(jsonData['attachments']);

    return MedicalData(
      appointments: appointments,
      chronicDiseases: chronicDiseases,
      attachments: attachments,
    );
  }
}
