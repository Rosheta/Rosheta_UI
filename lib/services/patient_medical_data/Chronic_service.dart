import 'dart:convert';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:rosheta_ui/models/patient_medical_data/Chronic_model.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class ChronicDiseaseListApi {
  Future<List<ChronicDisease>> fetchChronicDiseaseList() async {
    final String apiUrl = dotenv.env['API_URL']!;
    final url = '$apiUrl/chronic_disease_list';
    try {
      // String accessToken = await getAccessToken();

      // http.Response response = await http.get(
      //   Uri.parse(url),
      //   headers: {
      //     'Content-Type': 'application/json',
      //     'Authorization': 'Bearer $accessToken',
      //   },
      // );

      // if (response.statusCode == 200 || response.statusCode == 201) {
      if (true) {
        // List<dynamic> jsonData = jsonDecode(response.body);
        List<dynamic> jsonData = [
          {
            "name": "Diabetes",
            "date": "2020-01-15",
            "notes": "Requires daily insulin injections."
          },
          {
            "name": "Hypertension",
            "date": "2018-05-10",
            "notes": "Blood pressure under control with medication."
          },
          {
            "name": "Asthma",
            "date": "2019-09-20",
            "notes": "Uses inhaler as needed."
          }
        ];
        List<ChronicDisease> chronicDiseaseList = jsonData
            .map((json) => ChronicDisease.fromJson(json))
            .toList(); // Map JSON data to ChronicDisease objects

        return chronicDiseaseList;
      } else {
        throw Exception('Failed to load chronic disease list');
      }
    } catch (e) {
      throw Exception('Failed to load chronic disease list');
    }
  }

  Future<String> getAccessToken() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('access_token') ?? '';
  }
}
