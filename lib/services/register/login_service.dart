import 'dart:convert';
import 'package:rosheta_ui/models/register/login_model.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class LoginApi {
  Future<bool> login(String email, String password) async {
    final prefs = await SharedPreferences.getInstance();
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
          'devicetoken': prefs.getString('devicetoken'),
        }),
      );
      // Deserialize body to be accessible
      if (response.statusCode == 200 || response.statusCode == 201) {
        String data = response.body;
        var jsonData = jsonDecode(data);
        Login tokens = Login.fromJson(jsonData);
        final prefs = await SharedPreferences.getInstance();
        await prefs.setString('acesstoken', tokens.accessToken);
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
