import 'dart:convert';
import 'dart:typed_data';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:rosheta_ui/models/profile/profile_model.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class ProfileApi {
  Future<Profile> featchProfile() async {
    final String apiUrl = dotenv.env['API_URL']!;
    final url = '$apiUrl/profile';
    try {
      String accessToken =
          await getAccessToken(); // Assuming this method gets the access token

      http.Response response = await http.get(
        Uri.parse(url),
        headers: {
          'Content-Type': 'application/json',
          'Authorization':
              'Bearer $accessToken', // Include access token in Authorization header
        },
      );
      // Deserialize body to be accessible
      if (response.statusCode == 200 || response.statusCode == 201) {
        String data = response.body;
        var jsonData = jsonDecode(data);

        Profile dataProfile = Profile.fromJson(jsonData);

        return dataProfile;
      } else {
        print('Status code: ${response.statusCode}');
      }
    } catch (e) {
      print('Exception: $e');
    }
    throw Exception('Profile failed');
  }

  Future<String> getAccessToken() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('acesstoken') ?? '';
  }
}
