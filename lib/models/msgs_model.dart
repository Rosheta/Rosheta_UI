class Messages {
  final String? userId;
  final List<dynamic>? msgs;

  Messages({this.userId , this.msgs});

  factory Messages.fromJson(Map<String, dynamic> jsonData) {
    return Messages(
      userId: jsonData['userId'],
      msgs: jsonData['messages']
    );
  }
}
