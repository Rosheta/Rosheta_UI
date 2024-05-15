import 'dart:convert';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:rosheta_ui/models/patient_medical_data/Chronic_model.dart';
import 'package:rosheta_ui/models/patient_medical_data/Appointment_model.dart';

class AppointmentListApi {
  Future<List<Appointment>> fetchAppointments() async {
    final String apiUrl = dotenv.env['API_URL']!;
    final url = '$apiUrl/patient/appointments';

    final String token = await getAccessToken();
    try {
      http.Response response = await http.get(
        Uri.parse(url),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
      );
      if (response.statusCode == 200 || response.statusCode == 201) {
        // List<dynamic> jsonData = [
        //   {
        //     "Name": "Appointment 1",
        //     "Date": "2024-05-03",
        //     "DoctorId": "Dr. Smith",
        //     "Prescription": "Prescription 1///Prescription 2///Prescription 3",
        //     "Notes": "Notes 1",
        //     "ChronicDiseases": [
        //       {"Name": "Disease 1", "Date": "2023-01-01", "Notes": "Disease 1 notes"},
        //       {"Name": "Disease 2", "Date": "2023-02-01", "Notes": "Disease 2 notes"}
        //     ]
        //   },
        //   {
        //     "Name": "Appointment 1",
        //     "Date": "2024-05-03",
        //     "DoctorId": "Dr. Smith",
        //     "Prescription": "Prescription 1///p2///p3",
        //     "Notes": "Notes 1",
        //     "ChronicDiseases": [
        //       {"Name": "Disease 1", "Date": "2023-01-01", "Notes": "Disease 1 notes"},
        //       {"Name": "Disease 2", "Date": "2023-02-01", "Notes": "Disease 2 notes"}
        //     ]
        //   }
        // ];

        List<dynamic> jsonData = jsonDecode(response.body);
        List<Appointment> appointmentList =
            jsonData.map((json) => Appointment.fromJson(json)).toList();

        return appointmentList;
      } else {
        throw Exception('Failed to load appointments');
      }
    } catch (e) {
      throw Exception('Failed to load appointments');
    }
  }

  Future<String> getAccessToken() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('acesstoken') ?? '';
  }
}
