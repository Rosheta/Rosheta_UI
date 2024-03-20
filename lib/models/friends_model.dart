class Friends {
  final List<dynamic>? chatUser;

  Friends({this.chatUser});

  factory Friends.fromJson(Map<String, dynamic> jsonData) {
    return Friends(chatUser: jsonData['friends']);
  }
}
