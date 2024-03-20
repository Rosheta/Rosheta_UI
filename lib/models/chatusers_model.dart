// create model for list of chatuser_model
import 'package:rosheta_ui/models/chatuser_model.dart';

class ChatUsers {
  final List<ChatUser>? chatUsers;

  ChatUsers({this.chatUsers});

  factory ChatUsers.fromJson(Map<String,dynamic> jsonData) {
    return ChatUsers(
      chatUsers: jsonData['chatUsers']
    );
  }
}