import 'dart:convert';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import 'package:rosheta_ui/models/doctors/MedicalData_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DoctorDataApi {
  Future<MedicalData> fetchDoctorData(String token) async {
    final String apiUrl = dotenv.env['API_URL']!;
    final url = '$apiUrl/doctor/patient/data';

    try {
      String accessToken = await getAccessToken();

      http.Response response = await http.get(
        Uri.parse(url),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $accessToken',
          'accesscontrol': 'Bearer $token'
        },
      );
      if (response.statusCode == 200 || response.statusCode == 201) {
        Map<String, dynamic> jsonMap = jsonDecode(response.body);
        MedicalData medicalData = MedicalData.fromJson(jsonMap);
        return medicalData;
      } else {
        throw Exception('Failed to load data');
      }
    } catch (e) {
      throw Exception('Failed to load data');
    }
  }

  Future<String> getAccessToken() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('acesstoken') ?? '';
  }
}
