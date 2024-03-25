import 'package:shared_preferences/shared_preferences.dart';
import 'package:rosheta_ui/models/friends_model.dart';
import 'package:rosheta_ui/models/friend_model.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:rosheta_ui/models/msgs_model.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class ChatApi {
  Future<String> getAccessToken() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('acesstoken') ?? '';
  }

  Future<List<Friend>> getfriends() async {
    final String apiUrl = dotenv.env['API_URL']!;
    final url = '$apiUrl/getChats';
    final String token = await getAccessToken();

    try {
      http.Response response = await http.get(
        Uri.parse(url),
        headers: {
          'Content-Type': 'application/json',
          'Authorization':
              'Bearer $token', // Include access token in Authorization header
        },
      );

      // Deserialize body to be accessible
      if (response.statusCode == 200 || response.statusCode == 201) {
        String data = response.body;
        var jsonData = jsonDecode(data);
        Friends friends = Friends.fromJson(jsonData);
        List<Friend> listOfFriends =
            friends.chatUser!.map((e) => Friend.fromJson(e)).toList();
        return listOfFriends;
      } else {
        print('Status code: ${response.statusCode}');
        return [];
      }
    } catch (e) {
      print('Exception: $e');
      return [];
    }
  }

  Future<Messages> getmsgs(String chatId) async {
    final String apiUrl = dotenv.env['API_URL']!;
    final url = '$apiUrl/getChatContent?chatId=${chatId}';
    final String token = await getAccessToken();

    try {
      http.Response response = await http.get(
        Uri.parse(url),
        headers: {
          'Content-Type': 'application/json',
          'Authorization':
              'Bearer $token', // Include access token in Authorization header
        },
      );

      // Deserialize body to be accessible
      if (response.statusCode == 200 || response.statusCode == 201) {
        String data = response.body;
        var jsonData = jsonDecode(data);
        Messages messages = Messages.fromJson(jsonData);
        return messages;
      } else {
        print('Status code: ${response.statusCode}');
        return Messages();
      }
    } catch (e) {
      print('Exception: $e');
      return Messages();
    }
  }

  Future<void> startChat(String secondUserId) async{
    final String apiUrl = dotenv.env['API_URL']!;
    final url = '$apiUrl/startChat';
    final String token = await getAccessToken();

    try {
      http.Response response = await http.post(
        Uri.parse(url),
        headers: {
          'Content-Type': 'application/json',
          'Authorization':
              'Bearer $token', // Include access token in Authorization header
        },
        body: jsonEncode({
          'userId': secondUserId,
        }),
      );

      // Deserialize body to be accessible
      if (response.statusCode == 200 || response.statusCode == 201) {
        print('startChat: ${response.body}');
      } else {
        print('Status code: ${response.statusCode}');
        print('startChat: ${response.body}');
      }
    } catch (e) {
      print('Exception: $e');
    }
  }
}
