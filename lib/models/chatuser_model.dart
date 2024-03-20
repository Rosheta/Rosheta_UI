// create a model class for structure of chat user

class ChatUser {
  final String? chatId;
  final String? name;
  final String? message;
  final String? time;
  final String? avatarUrl;

  ChatUser({this.chatId , this.name, this.message, this.time, this.avatarUrl});

  factory ChatUser.fromJson(Map<String, dynamic> jsonData) {
    return ChatUser(
      chatId: jsonData['chatId'],
      name: jsonData['name'],
      message: jsonData['message'],
      time: jsonData['time'],
      avatarUrl: jsonData['avatarUrl'],
    );
  }
}
