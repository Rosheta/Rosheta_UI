import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import 'package:rosheta_ui/models/profile/profile_model.dart';
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

class EditProfileApi {
  Future<bool> editprofile({required Profile pr}) async {
    final String apiUrl = dotenv.env['API_URL']!;
    final url = '$apiUrl/profile';
    try {
      String accessToken =
          await getAccessToken();

      http.Response response = await http.put(
        Uri.parse(url),
        headers: {
          'Content-Type': 'application/json',
          'Authorization':
              'Bearer $accessToken',
        },
        body: json.encode({
          'department': pr.department,
          'userName': pr.userName,
          'name': pr.name,
          'gender': pr.gender,
          'government': pr.government,
          'email': {"value": pr.email, "visible": pr.viewemail},
          'phone': {"value": pr.phone, "visible": pr.viewphone},
          'date': {"value": pr.date, "visible": pr.viewdate},
          'ID': pr.ID,
          'location': pr.location,
        }),
      );
      if (response.statusCode == 200 || response.statusCode == 201) {
        return true;
      } else {
        return false;
      }
    } catch (e) {
      return false;
    }
  }

  Future<String> getAccessToken() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('acesstoken') ?? '';
  }
}
