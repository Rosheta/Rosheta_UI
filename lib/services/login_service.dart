import 'dart:convert';
import 'package:rosheta_ui/models/login_model.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class LoginApi {
  Future<void> login(String email, String password) async {
    const url = 'http://127.0.0.1:8000/login';
    try {
      // http request for login service
      http.Response response = await http.post(
        Uri.parse(url),
        headers: {
          'Content-Type': 'application/json',
        },
        body: {
          'email': email,
          'password': password,
        },
      );

      // Deserialize body to be accessible
      if (response.statusCode == 200 || response.statusCode == 201) {
        String data = response.body;
        var jsonData = jsonDecode(data);
        Login tokens = Login.fromJson(jsonData);
        // store tokens locally to be accessible again
        print('after request.....................');
        print('accesstoken: ${tokens.accessToken}');
        print('refreshtoken: ${tokens.refreshToken}');
        final prefs = await SharedPreferences.getInstance();
        await prefs.setString('acesstoken', tokens.accessToken);
        await prefs.setString('refreshtoken', tokens.refreshToken);
        return ;
      } else {
        print('Status code: ${response.statusCode}');
      }
    } catch (e) {
      print('Exception: $e');
    }
    throw Exception('Login failed');
  }

  Future<String> getAccessToken() async{
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('acesstoken') ?? '';
  }

  Future<String> getRefreshToken() async{
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('refreshtoken') ?? '';
  }
}
