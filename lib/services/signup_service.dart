import 'package:http/http.dart' as http;
import 'dart:convert';

class SignupApi {
  Future<bool> signup(
      {required email,
      required password,
      required name,
      required phone,
      required ssn,
      required birthdate,
      required type}) async {
    String url = 'http://192.168.1.2:5000/register';
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
      } else
        return false;
    } catch (e) {
      print("Exception: $e");
      return false;
    }
  }
}
