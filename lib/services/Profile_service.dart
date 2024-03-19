import 'dart:convert';
import 'package:rosheta_ui/models/profile_model.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class ProfileApi {
  Future<Profile> featchProfile() async {
    const url = 'http://192.168.1.2:5000/profile';
    try {
      String accessToken = await getAccessToken(); // Assuming this method gets the access token
          // "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJlbWFpbCI6InRvdG9AZ21haWwuY29tIiwiaWQiOiI2NWY4YzBlM2YwMzcwMzQxZjJlYjEwZDAiLCJpYXQiOjE3MTA4MTEzNDAsImV4cCI6MTcxMDgxNDk0MH0.QF5dOVusdSxLbL8ihRb3y973w_TA-7xbGlXIhvjBldU";
      
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
    throw Exception('Login failed');
  }

  Future<String> getAccessToken() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('acesstoken') ?? '';
  }
}
