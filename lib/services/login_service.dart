import 'dart:convert';
import 'package:rosheta_ui/models/login_model.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class LoginApi {
  Future<bool> login(String email, String password) async {
    final String apiUrl = dotenv.env['API_URL']!;
    final url = '$apiUrl/login';
    try {
      http.Response response = await http.post(
        Uri.parse(url),
        headers: {
          'Content-Type': 'application/json',
        },
        body: json.encode({
          'email': email,
          'password': password,
        }),
      );

      // Deserialize body to be accessible
      if (response.statusCode == 200 || response.statusCode == 201) {
        String data = response.body;
        var jsonData = jsonDecode(data);
        Login tokens = Login.fromJson(jsonData);
        // store tokens locally to be accessible again
        final prefs = await SharedPreferences.getInstance();
        await prefs.setString('acesstoken', tokens.accessToken);
        // await prefs.setString('refreshtoken', tokens.refreshToken);
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

  Future<String> getAccessToken() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('acesstoken') ?? '';
  }

  Future<String> getRefreshToken() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('refreshtoken') ?? '';
  }
}
