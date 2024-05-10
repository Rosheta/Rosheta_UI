import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

class SendAppointment {
  Future<bool> sendAppointment(
      {required String prescription,
      required String note,
      required List<Map<String, String>> chronicDiseases,
      required String token}) async {
    final String apiUrl = dotenv.env['API_URL']!;
    final url = '$apiUrl/doctor/appointment';
    try {
      String accessToken = await getAccessToken();

      http.Response response = await http.post(
        Uri.parse(url),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $accessToken',
          'accesscontrol': token
        },
        body: json.encode({
          'prescription': prescription,
          'notes': note,
          'chronics': chronicDiseases,
        }),
      );
      print(
          ".......................................................................");
      print("send");
      print(accessToken);
      print(response.statusCode);
      print(response.body);
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
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('acesstoken') ?? '';
  }
}
