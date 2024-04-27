class Attachment {
  final String? fileHash;
  final String? name;
  final String? ext;
  final String? time;

  Attachment({this.fileHash, this.name, this.ext, this.time});

  factory Attachment.fromJson(Map<String, dynamic> jsonData) {
    return Attachment(
      fileHash: jsonData['fileHash'],
      name: jsonData['name'],
      ext: jsonData['ext'],
      time: jsonData['time']
    );
  }
}