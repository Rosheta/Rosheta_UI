class Attachments {
  final List<dynamic>? attachment;

  Attachments({this.attachment});

  factory Attachments.fromJson(Map<String, dynamic> jsonData) {
    return Attachments(attachment: jsonData['files']);
  }
}