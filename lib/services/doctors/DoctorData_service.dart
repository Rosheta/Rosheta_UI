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
      String accessToken = await getAccessToken();

      http.Response response = await http.get(
        Uri.parse(url),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $accessToken',
          'accesscontrol': token
        },
      );
      print(
          ".......................................................................");
      print("all");
      print(accessToken);
      print(response.statusCode);
      print(response.body);
      if (response.statusCode == 200 || response.statusCode == 201) {
        // // if (true) {
        // String jsonData = '''
        // {
        //   "appointments": [
        //     {
        //       "name": "Appointment 1",
        //       "date": "2024-05-03",
        //       "doctor_name": "Dr. Smith",
        //       "prescription": "Prescription 1",
        //       "notes": "Notes 1",
        //       "chronic_diseases": [
        //         {"name": "Disease 1", "date": "2023-01-01", "notes": "Disease 1 notes"},
        //         {"name": "Disease 2", "date": "2023-02-01", "notes": "Disease 2 notes"}
        //       ]
        //     },
        //     {
        //       "name": "Appointment 2",
        //       "date": "2024-05-05",
        //       "doctor_name": "Dr. Johnson",
        //       "prescription": "Prescription 2",
        //       "notes": "Notes 2",
        //       "chronic_diseases": [
        //         {"name": "Disease 3", "date": "2023-03-01", "notes": "Disease 3 notes"}
        //       ]
        //     }
        //   ],
        //   "chronic_diseases": [
        //     {"name": "Chronic Disease 1", "date": "2023-01-01", "notes": "Chronic Disease 1 notes"},
        //     {"name": "Chronic Disease 2", "date": "2023-02-01", "notes": "Chronic Disease 2 notes"}
        //   ],
        //   "attachments": [
        //     {"Hash": "hash1", "Filename": "File 1", "Extension": ".pdf", "date": "2023-01-01"},
        //     {"Hash": "hash2", "Filename": "File 2", "Extension": ".jpg", "date": "2023-02-01"}
        //   ]
        // }
        // ''';
        Map<String, dynamic> jsonMap = jsonDecode(response.body);
        print(jsonMap);

        // Create MedicalData instance using the fromJson factory constructor
        MedicalData medicalData = MedicalData.fromJson(jsonMap);
        return medicalData;
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
