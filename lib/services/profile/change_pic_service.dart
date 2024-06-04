import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class ChangePicApi {
  Future<String> changePic({required profileImage}) async {
    final String apiUrl = dotenv.env['API_URL']!;
    final url = '$apiUrl/profile/picture';
    try {
      String accessToken = await getAccessToken(); 

      var request = http.MultipartRequest('PUT', Uri.parse(url));
      request.files
          .add(await http.MultipartFile.fromPath('photo', profileImage.path));
      request.headers['Authorization'] = 'Bearer $accessToken';
      var response = await request.send();

      // Get the response body
      String responseBody = await response.stream.bytesToString();
      if (response.statusCode == 200 || response.statusCode == 201) {
        return responseBody;
      } else {
        return "";
      }
    } catch (e) {
      return "";
    }
  }

  Future<String> getAccessToken() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('acesstoken') ?? '';
  }
}
