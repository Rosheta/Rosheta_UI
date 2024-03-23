import 'package:http/http.dart' as http;
import 'dart:convert';

class EditProfileApi {
  Future<bool> editprofile(
      {required userID,
      required email,
      required name,
      required phone,
      required ssn,
      required birthdate}) async {
    String url = 'http://192.168.1.2:5000/editProfile';
    try {
      http.Response response = await http.post(
        Uri.parse(url),
        headers: {
          'Content-Type': 'application/json',
        },
        body: json.encode({
          'userID': userID,
          'email': email,
          'name': name,
          'phone': phone,
          'ssn': ssn,
          'birthdate': birthdate,
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
