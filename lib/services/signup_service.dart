import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class SignupApi {
  Future<bool> signup(
      {required email,
      required password,
      required name,
      required phone,
      required ssn,
      required birthdate,
      required type}) async {
        
    final String apiUrl = dotenv.env['API_URL']!;
    final url = '$apiUrl/register';
    try {
      http.Response response = await http.post(
        Uri.parse(url),
        headers: {
          'Content-Type': 'application/json',
        },
        body: json.encode({
          'email': email,
          'password': password,
          'name': name,
          'phone': phone,
          'ssn': ssn,
          'birthdate': birthdate,
          'type': type,
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
}
