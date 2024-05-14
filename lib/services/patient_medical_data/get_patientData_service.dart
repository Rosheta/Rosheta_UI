import 'dart:convert';
import 'dart:typed_data';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import 'package:rosheta_ui/models/doctors/MidicalData_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class GetDataApi {
  Future<String> getAccessToken() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('acesstoken') ?? '';
  }

  Future<String> getData(userID) async {
    final String apiUrl = dotenv.env['API_URL']!;
    final url = '$apiUrl/patient/getData';
    final String token = await getAccessToken();
    try {
      // http.Response response = await http.post(
      //   Uri.parse(url),
      //   headers: {
      //     'Content-Type': 'application/json',
      //     'Authorization': 'Bearer $token',
      //   },
      //   body: json.encode({
      //     'userID': userID,
      //   }),
      // );
      // if (response.statusCode == 200 || response.statusCode == 201) {
      //   Map<String, dynamic> jsonMap = jsonDecode(response.body);
      //   String token = jsonMap['token'];
      //   return token;
      if(true){
        return "t";
      } else {
        throw Exception('Failed to load data');
      }
    } catch (e) {
      throw Exception('Failed to load data');
    }
  }


Future<bool> IsValid(userID) async {
    final String apiUrl = dotenv.env['API_URL']!;
    final url = '$apiUrl/patient/IsValidID';
    final String token = await getAccessToken();
    try {
      http.Response response = await http.post(
        Uri.parse(url),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
        body: json.encode({
          'userID': userID,
        }),
      );
      if (response.statusCode == 200 || response.statusCode == 201) {
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

}
