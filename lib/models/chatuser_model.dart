// create a model class for structure of chat user

class ChatUser {
  final String? name;
  final String? message;
  final String? time;
  final String? avatarUrl;

  ChatUser({this.name, this.message, this.time, this.avatarUrl});

  factory ChatUser.fromJson(Map<String, dynamic> jsonData) {
    return ChatUser(
      name: jsonData['name'],
      message: jsonData['message'],
      time: jsonData['time'],
      avatarUrl: jsonData['avatarUrl'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'message': message,
      'time': time,
      'avatarUrl': avatarUrl,
    };
  }
}
