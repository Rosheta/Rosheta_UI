import 'dart:convert';
// import 'package:rosheta_ui/models/login_model.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_dotenv/flutter_dotenv.dart';

// class search_service {
//   Future<List<dynamic>> fetchSuggestions(String query) async {
//     // final Uri uri = Uri.parse('http://10.0.2.2:3000/api/data?query=$query'); // for mobile emulator
//     // final Uri uri = Uri.parse('http://192.168.1.7:3000/api/data?query=$query'); // for actual mobile over wifi network

//     final String apiUrl = dotenv.env['API_URL']!;
//     final uri = '$apiUrl/search?query=$query';
//     print('Fetching suggestions for query: $query'); // Check if the query is correct
//     try {
//       print("enter try");
//       final response = await http.get(Uri.parse(uri));
//       // final response = await http.post(Uri.parse(uri), body: json.encode({'query': query}));
//       if (response.statusCode == 200) {
//         final List<dynamic> data = json.decode(response.body);
//         return data;
//       } else {
//         throw Exception('Failed to fetch data from server');
//       }
//     } catch (e) {
//       throw Exception('Error: $e');
//     }
//   }
// }

class search_service {
  Future<List<dynamic>> fetchSuggestions(
      Map<String, dynamic> requestData) async {
    final String apiUrl = dotenv.env['API_URL']!;
    final String uri = '$apiUrl/search';

    print(
        'Fetching suggestions for query: $requestData'); // Check if the query is correct

    try {
      final response = await http.post(
        Uri.parse(uri),
        body: json.encode(requestData),
        headers: {'Content-Type': 'application/json'},
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
}
