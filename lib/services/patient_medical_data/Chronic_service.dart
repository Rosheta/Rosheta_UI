import 'dart:convert';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:rosheta_ui/models/patient_medical_data/Chronic_model.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class ChronicDiseaseListApi {
  Future<List<ChronicDisease>> fetchChronicDiseaseList() async {
    final String apiUrl = dotenv.env['API_URL']!;
    final url = '$apiUrl/patient/diseases';
    String accessToken = await getAccessToken();
    try {
      http.Response response = await http.get(
        Uri.parse(url),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $accessToken',
        },
      );
      if (response.statusCode == 200 || response.statusCode == 201) {
        List<dynamic> jsonData = jsonDecode(response.body);
        List<ChronicDisease> chronicDiseaseList = jsonData
            .where((json) => json['Name'] != null && json['Name'].isNotEmpty)
            .map((json) => ChronicDisease.fromJson(json))
            .toList();
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
    return prefs.getString('acesstoken') ?? '';
  }
}
