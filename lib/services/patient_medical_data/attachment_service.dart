import 'dart:convert';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import 'package:rosheta_ui/models/patient_medical_data/attachment_model.dart';
import 'package:rosheta_ui/models/patient_medical_data/attachments_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AttachmentApi {
  Future<String> getAccessToken() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('acesstoken') ?? '';
  }

  Future<List<Attachment>> getAttachments() async {
    final String apiUrl = dotenv.env['API_URL']!;
    final url = '$apiUrl/patient/getFiles';
    final String token = await getAccessToken();

    try {
      http.Response response = await http.get(
        Uri.parse(url),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
      );

      // Deserialize body to be accessible
      if (response.statusCode == 200 || response.statusCode == 201) {
        String data = response.body;
        var jsonData = jsonDecode(data);
        Attachments attachments = Attachments.fromJson(jsonData);
        List<Attachment> listOfFiles =
            attachments.attachment!.map((e) => Attachment.fromJson(e)).toList();
        return listOfFiles;
      } else {
        print('Status code: ${response.statusCode}');
        return [];
      }
    } catch (e) {
      print('Exception: $e');
      return [];
    }
  }

  Future<bool> deleteAttachment(String hash) async {
    final String apiUrl = dotenv.env['API_URL']!;
    final url = '$apiUrl/patient/deleteFile?hash=$hash';
    final String token = await getAccessToken();

    try {
      http.Response response = await http.delete(
        Uri.parse(url),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        print('Attachment deleted successfully');
        return true;
      } else {
        print('Status code: ${response.statusCode}');
        return false;
      }
    } catch (e) {
      throw Exception('Failed to delete attachment');
    }
  }
}
