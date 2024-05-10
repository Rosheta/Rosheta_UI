import 'dart:convert';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:rosheta_ui/models/patient_medical_data/Chronic_model.dart';
import 'package:rosheta_ui/models/patient_medical_data/Appointment_model.dart';

class AppointmentListApi {
  Future<List<Appointment>> fetchAppointments() async {
    // final String apiUrl = dotenv.env['API_URL']!;
    // final url = '$apiUrl/patient/appointments';

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
      print(
          ".......................................................................");
      print("appoint");
      print(token);
      print(response.statusCode);
      print(response.body);

      if (response.statusCode == 200 || response.statusCode == 201) {
        // if (true) {
        //   List<dynamic> jsonData = [
        //     {
        //       "name": "John Doe",
        //       "date": "2024-04-28",
        //       "doctor_name": "Dr. Smith",
        //       "prescription": "Take medication X twice a day",
        //       "notes": "Patient reported improvement in symptoms",
        //       "chronic_diseases": [
        //         {
        //           "name": "Diabetes",
        //           "date": "2017-05-20",
        //           "notes": "Requires regular monitoring and insulin injections"
        //         }
        //       ]
        //     },
        //     {
        //       "name": "Jane Smith",
        //       "date": "2024-05-01",
        //       "doctor_name": "Dr. Johnson",
        //       "prescription": "Physical therapy sessions recommended",
        //       "notes": "Patient experiencing lower back pain",
        //       "chronic_diseases": [
        //         {
        //           "name": "Arthritis",
        //           "date": "2019-10-10",
        //           "notes": "Managed with pain medication and physiotherapy"
        //         },
        //         {
        //           "name": "Arthritis",
        //           "date": "2018-01-15",
        //           "notes": "Under control with medication"
        //         },
        //         {
        //           "name": "Arthritis",
        //           "date": "2019-10-10",
        //           "notes": "Managed with pain medication and physiotherapy"
        //         }
        //       ]
        //     }
        //   ];

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
