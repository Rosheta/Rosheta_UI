// create model for list of chatuser_model
import 'package:rosheta_ui/models/chatuser_model.dart';

class ChatUsers {
  final List<dynamic>? chatUser;

  ChatUsers({this.chatUser});

  factory ChatUsers.fromJson(Map<String,dynamic> jsonData) {
    return ChatUsers(
      chatUser: jsonData['chatUsers']
    );
  }
}