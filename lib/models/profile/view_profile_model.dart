import 'dart:typed_data';

class ViewProfile {
  final Uint8List profileImage;
  final String userName;
  final String email;
  final String phone;
  final String date;
  final String ID;
  final bool viewemail;
  final bool viewphone;
  final bool viewdate;
  final bool viewID;

  ViewProfile(
      {required this.profileImage,
      required this.userName,
      required this.email,
      required this.phone,
      required this.date,
      required this.ID,
      required this.viewemail,
      required this.viewphone,
      required this.viewdate,
      required this.viewID});

  factory ViewProfile.fromJson(Map<String, dynamic> jsonData) {
    Uint8List proImage;
    if (jsonData['profileImage'] == null) {
      proImage = Uint8List.fromList([]);
    } else {
      proImage = jsonData['profileImage'];
    }
    return ViewProfile(
      profileImage: proImage,
      userName: jsonData['userName'],
      email: jsonData['email'],
      phone: jsonData['phone'],
      date: jsonData['date'][0],
      ID: jsonData['ID'],
      viewemail: jsonData['viewemail'],
      viewphone: jsonData['viewphone'],
      viewdate: jsonData['viewdate'],
      viewID: jsonData['viewID'],
    );
  }
}
