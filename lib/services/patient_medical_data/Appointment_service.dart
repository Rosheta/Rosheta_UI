import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
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
        print(
            "....................................................................");
        print(response.body);
        List<dynamic> jsonData = jsonDecode(response.body);

        List<Appointment> appointmentList =
            jsonData.map((json) => Appointment.fromJson(json)).toList();
        print(appointmentList);
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
