class Friend {
  final String? chatId;
  final String? name;
  final String? message;
  final String? time;
  final String? avatarUrl;

  Friend({this.chatId, this.name, this.message, this.time, this.avatarUrl});

  factory Friend.fromJson(Map<String, dynamic> jsonData) {
    return Friend(
      chatId: jsonData['chatId'],
      name: jsonData['name'],
      message: jsonData['lastmsg'],
      time: jsonData['time'],
      avatarUrl: jsonData['ImageUrl'],
    );
  }
}
