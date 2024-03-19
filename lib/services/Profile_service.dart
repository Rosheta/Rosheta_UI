import 'dart:convert';
import 'package:rosheta_ui/models/profile_model.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class ProfileApi {
  Future<Profile> featchProfile(String email, String password) async {
    const url = 'http://192.168.1.2:5000/profile';
    try {
      String accessToken =
          await getAccessToken(); // Assuming this method gets the access token

// Perform the GET request
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
        // store tokens locally to be accessible again
        // await prefs.setString('refreshtoken', tokens.refreshToken);
        return dataProfile;
      } else {
        print('Status code: ${response.statusCode}');
      }
    } catch (e) {
      print('Exception: $e');
    }
    throw Exception('Login failed');
  }

  Future<String> getAccessToken() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('acesstoken') ?? '';
  }

  fetchProfile() {}
}
