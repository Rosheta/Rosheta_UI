import 'dart:convert';
import 'package:rosheta_ui/models/profile_model.dart';
import 'package:http/http.dart' as http;
import 'package:rosheta_ui/models/view_profile_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class viewProfileApi {
  Future<ViewProfile> viewProfile({required userId}) async {
    const url = 'http://192.168.1.2:5000/viewProfile';
    try {
      String accessToken =
          await getAccessToken(); // Assuming this method gets the access token

      // Construct the URL with the user ID as a query parameter
      Uri uri = Uri.parse('$url?userId=$userId');

      http.Response response = await http.get(
        uri,
        headers: {
          'Content-Type': 'application/json',
          'Authorization':
              'Bearer $accessToken', // Include access token in Authorization header
        },
      );
      if (response.statusCode == 200 || response.statusCode == 201) {
        String data = response.body;
        var jsonData = jsonDecode(data);
        ViewProfile dataProfile = ViewProfile.fromJson(jsonData);
        return dataProfile;
      } else {
        print('Status code: ${response.statusCode}');
      }
    } catch (e) {
      print('Exception: $e');
    }
    throw Exception('Login failed');

    // Handle response here
  }

  Future<String> getAccessToken() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('acesstoken') ?? '';
  }
}
