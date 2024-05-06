import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class SendAppointment {
  Future<bool> sendAppointment({
    required String prescription,
    required String note,
    required List<Map<String, String>> chronicDiseases,
  }) async {
    final String apiUrl = dotenv.env['API_URL']!;
    final url = '$apiUrl/appointments';
    try {
      String accessToken = await getAccessToken(); 

      http.Response response = await http.post(
        Uri.parse(url),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $accessToken',
        },
        body: json.encode({
          'prescription': prescription,
          'note': note,
          'chronicDiseases': chronicDiseases,
        }),
      );
      if (response.statusCode == 200 || response.statusCode == 201) {
        return true;
      } else {
        return false;
      }
    } catch (e) {
      print("Exception: $e");
      return false;
    }
  }

  Future<String> getAccessToken() async {
    // Assume this method retrieves the access token from SharedPreferences
    return 'your_access_token_here';
  }
}
