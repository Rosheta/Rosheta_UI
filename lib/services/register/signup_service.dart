import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class SignupApi {
  Future<String> signupDoctor(
      {required email,
      required name,
      required ssn,
      required clinicPosition,
      required gender,
      required password,
      required phone,
      required birthdate,
      required government,
      required department,
      required selectedFile}) async {
    final String apiUrl = dotenv.env['API_URL']!;
    final String url = '$apiUrl/doctor/register';

    try {
      var request = http.MultipartRequest('POST', Uri.parse(url));
      request.files
          .add(await http.MultipartFile.fromPath('file', selectedFile.path));

      // Add additional data fields
      request.fields['email'] = email;
      request.fields['name'] = name;
      request.fields['ssn'] = ssn;
      request.fields['location'] = clinicPosition;
      request.fields['gender'] = gender;
      request.fields['password'] = password;
      request.fields['phone'] = phone;
      request.fields['birthdate'] = birthdate;
      request.fields['government'] = government;
      request.fields['department'] = department;

      // Send the request
      var response = await request.send();
      if (response.statusCode == 200 || response.statusCode == 201) {
        return 'true';
      } else {
        return response.toString();
      }
    } catch (e) {
      return 'false';
    }
  }

  Future<String> signupPatient(
      {required email,
      required name,
      required ssn,
      required gender,
      required password,
      required phone,
      required birthdate}) async {
    final String apiUrl = dotenv.env['API_URL']!;
    final String url = '$apiUrl/patient/register';
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
          'gender': gender,
        }),
      );
      if (response.statusCode == 200 || response.statusCode == 201) {
        return 'true';
      } else {
        return response.body;
      }
    } catch (e) {
      return 'false';
    }
  }

  Future<String> signupLab(
      {required email,
      required name,
      required labPosition,
      required password,
      required phone,
      required government,
      required selectedFile}) async {
    final String apiUrl = dotenv.env['API_URL']!;
    final String url = '$apiUrl/lab/register';

    try {
      var request = http.MultipartRequest('POST', Uri.parse(url));
      request.files
          .add(await http.MultipartFile.fromPath('file', selectedFile.path));

      // Add additional data fields
      request.fields['email'] = email;
      request.fields['name'] = name;
      request.fields['location'] = labPosition;
      request.fields['password'] = password;
      request.fields['phone'] = phone;
      request.fields['government'] = government;

      // Send the request
      var response = await request.send();
      if (response.statusCode == 200 || response.statusCode == 201) {
        return 'true';
      } else {
        return response.toString();
      }
    } catch (e) {
      return 'false';
    }
  }
}
