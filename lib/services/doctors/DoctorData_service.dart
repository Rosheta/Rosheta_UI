import 'dart:convert';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import 'package:rosheta_ui/models/doctors/MidicalData_model.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:rosheta_ui/models/patient_medical_data/Chronic_model.dart';
import 'package:rosheta_ui/models/patient_medical_data/Appointment_model.dart';

class DoctorDataApi {
  Future<MedicalData> fetchDoctorData(String token) async {
    final String apiUrl = dotenv.env['API_URL']!;
    final url = '$apiUrl/doctor/patient/data';
    print(
        ".......................................................................");
    print(url);

    try {
      // String accessToken = await getAccessToken();

      // http.Response response = await http.get(
      //   Uri.parse(url),
      //   headers: {
      //     'Content-Type': 'application/json',
      //     'Authorization': 'Bearer $accessToken',
      //     'accesscontrol': token
      //   },
      // );
      // if (response.statusCode == 200 || response.statusCode == 201) {
      if (true) {
        String jsonData = '''
        {
          "appointments": [
            {
              "Name": "Appointment 1",
              "Date": "2024-05-03",
              "DoctorId": "Dr. Smith",
              "Prescription": "Prescription 1",
              "Notes": "Notes 1",
              "ChronicDiseases": [
                {"Name": "Disease 1", "Date": "2023-01-01", "Notes": "Disease 1 notes"},
                {"Name": "Disease 2", "Date": "2023-02-01", "Notes": "Disease 2 notes"}
              ]
            },
            {
              "Name": "Appointment 2",
              "Date": "2024-05-05",
              "DoctorId": "Dr. Johnson",
              "Prescription": "Prescription 2",
              "Notes": "Notes 2",
              "ChronicDiseases": [
                {"Name": "Disease 3", "Date": "2023-03-01", "Notes": "Disease 3 notes"}
              ]
            }
          ],
          "chronics": [
            {"Name": "Chronic Disease 1", "Date": "2023-01-01", "Notes": "Chronic Disease 1 notes"},
            {"Name": "Chronic Disease 2", "Date": "2023-02-01", "Notes": "Chronic Disease 2 notes"}
          ],
          "files": [
            {"Hash": "hash1", "Filename": "File 1", "Extension": ".pdf", "date": "2023-01-01"},
            {"Hash": "hash2", "Filename": "File 2", "Extension": ".jpg", "date": "2023-02-01"}
          ]
        }
        ''';
        // Map<String, dynamic> jsonMap = jsonDecode(response.body);
        Map<String, dynamic> jsonMap = jsonDecode(jsonData);
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
