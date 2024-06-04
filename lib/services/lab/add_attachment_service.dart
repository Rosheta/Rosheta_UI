import 'package:http/http.dart' as http;
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AddAttachmentApi {
  Future<String> getAccessToken() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('acesstoken') ?? '';
  }

  Future<String> addAttachment({required userame, required selectedFile}) async {
    final String apiUrl = dotenv.env['API_URL']!;
    final String url = '$apiUrl/lab/upload';
    String accessToken = await getAccessToken();

    try {
      var request = http.MultipartRequest('POST', Uri.parse(url));
      request.files
          .add(await http.MultipartFile.fromPath('file', selectedFile.path));
      request.headers['Authorization'] = 'Bearer $accessToken';
      request.fields['username'] = userame;

      var response = await request.send();
      String responseBody = await response.stream.bytesToString();
      if (response.statusCode == 200 || response.statusCode == 201) {
        return 'true';
      } else {
        return responseBody;
      }
    } catch (e) {
      return 'Error , Please try again later';
    }
  }
}
