import 'dart:js_interop';
import 'dart:typed_data';

class ViewProfile {
  final String userID;
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
      {required this.userID,
      required this.profileImage,
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
    return ViewProfile(
      userID: jsonData['userID'],
      profileImage: jsonData['profileImage'],
      userName: jsonData['userName'],
      email: jsonData['email'],
      phone: jsonData['phone'],
      date: jsonData['date'],
      ID: jsonData['ID'],
      viewemail: jsonData['viewemail'],
      viewphone: jsonData['viewphone'],
      viewdate: jsonData['viewdate'],
      viewID: jsonData['viewID'],
    );
  }
}
