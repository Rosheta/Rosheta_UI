import 'package:http/http.dart' as http;
import 'dart:convert';

class changePicApi {
  Future<bool> changePic({required profileImage, required id}) async {
    String url = 'http://192.168.1.2:5000/changePic';
    try {
      http.Response response = await http.post(
        Uri.parse(url),
        headers: {
          'Content-Type': 'application/json',
        },
        body: json.encode({
          'profileImage': profileImage,
          'userID': id,
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
