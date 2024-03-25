import 'dart:typed_data';

class Profile {
  Uint8List profileImage;
  final String userName;
  final String email;
  final String phone;
  final String date;
  final String ID;
  final bool viewemail;
  final bool viewphone;
  final bool viewdate;
  final bool viewID;

  Profile(
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

  factory Profile.fromJson(Map<String, dynamic> jsonData) {
    final Uint8List proImage;

    if (jsonData['profileImage'] == null) {
      proImage = Uint8List.fromList([]);
    } else {
      proImage = jsonData['profileImage'];
    }
    return Profile(
      // profileImage: Uint8List.fromList([10, 20, 30, 40, 50]),
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
