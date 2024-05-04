class Attachment {
  final String? fileHash;
  final String? name;
  final String? ext;
  final String? time;

  Attachment({this.fileHash, this.name, this.ext, this.time});

  factory Attachment.fromJson(Map<String, dynamic> jsonData) {
    return Attachment(
      fileHash: jsonData['Hash'],
      name: jsonData['Filename'],
      ext: jsonData['Extension'],
      time: jsonData['date']
    );
  }
}