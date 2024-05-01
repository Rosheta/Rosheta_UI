import 'dart:convert';

import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class GiveAccessApi {
  Future<String> getAccessToken() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('acesstoken') ?? '';
  }

  Future<bool> giveAccess(username) async {
    final String apiUrl = dotenv.env['API_URL']!;
    final url = '$apiUrl/patient/giveAccess';
    final String token = await getAccessToken();
    try {
      http.Response response = await http.post(
        Uri.parse(url),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
        body: json.encode({
          'username': username,
        }),
      );


      // Deserialize body to be accessible
      if (response.statusCode == 200 || response.statusCode == 201) {
        return true;
      } else {
        print('Status code: ${response.statusCode}');
        return false;
      }
    } catch (e) {
      print('Exception: $e');
      return false;
    }
  }
}
