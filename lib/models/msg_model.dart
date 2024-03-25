class Message{
  String? message;
  String? sender;
  String? receiver;
  String? time;
  bool? isRead;

  Message({this.message, this.sender, this.receiver, this.time, this.isRead});

  factory Message.fromJson(Map<String, dynamic> jsonData){
    return Message(
      message: jsonData['message'],
      sender: jsonData['sender'],
      time: jsonData['time'], // split time to show only time
      isRead: jsonData['isSeen'],
    );
  }

}