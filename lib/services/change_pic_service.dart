import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

class changePicApi {
  Future<bool> changePic({required profileImage}) async {
    final String apiUrl = dotenv.env['API_URL']!;
    final url = '$apiUrl/profilePicture';
    try {
      String accessToken =
          await getAccessToken(); // Assuming this method gets the access token

      http.Response response = await http.put(
        Uri.parse(url),
        headers: {
          'Content-Type': 'application/json',
          'Authorization':
              'Bearer $accessToken', // Include access token in Authorization header
        },
        body: json.encode({
          'profileImage': profileImage,
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
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('acesstoken') ?? '';
  }
}
