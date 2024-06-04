import 'dart:convert';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import 'package:rosheta_ui/models/profile/view_profile_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ViewProfileApi {
  Future<ViewProfile> viewProfile({required userId}) async {
    final String apiUrl = dotenv.env['API_URL']!;
    final url = '$apiUrl/profileByID';
    try {
      String accessToken = await getAccessToken();
      Uri uri = Uri.parse('$url?userId=$userId');

      http.Response response = await http.get(
        uri,
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $accessToken',
        },
      );
      if (response.statusCode == 200 || response.statusCode == 201) {
        String data = response.body;
        var jsonData = jsonDecode(data);
        ViewProfile dataProfile = ViewProfile.fromJson(jsonData);
        return dataProfile;
      }
    } catch (e) {
      throw Exception('Login failed');
    }
    throw Exception('Login failed');
  }

  Future<String> getAccessToken() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('acesstoken') ?? '';
  }
}
