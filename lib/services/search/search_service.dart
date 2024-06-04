import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SearchAPI {
  Future<List<dynamic>> fetchSuggestions(
      Map<String, dynamic> requestData) async {
    final String apiUrl = dotenv.env['API_URL']!;
    final String uri = '$apiUrl/search';

    try {
      String accessToken = await getAccessToken();
      final response = await http.post(
        Uri.parse(uri),
        body: json.encode(requestData),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $accessToken',
        },
      );
      if (response.statusCode == 200) {
        final List<dynamic> data = json.decode(response.body);
        return data;
      } else {
        throw Exception('Failed to fetch data from server');
      }
    } catch (e) {
      throw Exception('Error: $e');
    }
  }

  Future<String> getAccessToken() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('acesstoken') ?? '';
  }
}
