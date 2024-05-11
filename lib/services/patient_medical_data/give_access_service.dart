import 'dart:convert';
import 'dart:typed_data';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import 'package:rosheta_ui/models/patient_medical_data/user_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class GiveAccessApi {
  Future<String> getAccessToken() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('acesstoken') ?? '';
  }

  Future<bool> giveAccess(username) async {
    final String apiUrl = dotenv.env['API_URL']!;
    final url = '$apiUrl/patient/giveAccess';
    final String token = await getAccessToken();
    try {
      http.Response response = await http.post(
        Uri.parse(url),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
        body: json.encode({
          'username': username,
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

  Future<Uint8List> getAttachment(String hash, String sharedtoken) async {
    final String apiUrl = dotenv.env['API_URL']!;
    final url = '$apiUrl/doctor/getFile?fileHash=$hash&token=$sharedtoken';
    final String token = await getAccessToken();
    try {
      final http.Client client = http.Client();
      final http.Request request = http.Request('GET', Uri.parse(url));
      request.headers['Content-Type'] = 'application/json';
      request.headers['Authorization'] = 'Bearer $token';

      final http.StreamedResponse response = await client.send(request);

      if (response.statusCode == 200 || response.statusCode == 201) {
        final List<Uint8List> chunks = [];
        await for (final List<int> chunk in response.stream) {
          chunks.add(Uint8List.fromList(chunk));
        }
        final Uint8List data =
            Uint8List.fromList(chunks.expand((x) => x).toList());
        print('Attachment retrieved successfully');
        return data;
      } else {
        print('Status code: ${response.statusCode}');
        return Uint8List(0);
      }
    } catch (e) {
      print('Error: $e');
      throw Exception('Failed to retrieve attachment');
    }
  }

  Future<User> getUser(username) async {
    final String apiUrl = dotenv.env['API_URL']!;
    final url = '$apiUrl/patient/user?username=$username';
    final String token = await getAccessToken();
    try {
      http.Response response = await http.get(
        Uri.parse(url),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
      );
      if (response.statusCode == 200 || response.statusCode == 201) {
        String data = response.body;
        var jsonData = jsonDecode(data);
        User dataUser = User.fromJson(jsonData);
        return dataUser;
      } else {
        print('Status code: ${response.statusCode}');
        User dataUser = User(profileImage: '', name: '', flag: false);
        print(dataUser.flag);
        return dataUser;
      }
    } catch (e) {
      print('Exception: $e');
      User dataUser = User(profileImage: '', name: '', flag: false);
      print(dataUser.flag);
      return dataUser;
    }
    // throw Exception('User not found');
  }
}
