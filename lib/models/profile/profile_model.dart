
// ignore_for_file: non_constant_identifier_names

class Profile {
  final String profileImage;
  final String userName;
  final String name;
  final String gender;
  final String ID;
  final String government;
  final String email;
  final String phone;
  final String date;
  final String department;
  final String location;
  final bool viewemail;
  final bool viewphone;
  final bool viewdate;

  Profile({
    required this.department,
    required this.profileImage,
    required this.userName,
    required this.name,
    required this.gender,
    required this.government,
    required this.email,
    required this.phone,
    required this.date,
    required this.ID,
    required this.viewemail,
    required this.viewphone,
    required this.viewdate,
    required this.location,
  });

  factory Profile.fromJson(Map<String, dynamic> jsonData) {
    final String profileImage;
    final String name;
    final String gender;
    final String ID;
    final String government;
    final String email;
    final String phone;
    final String date;
    final String department;
    final String location;
    final bool viewemail;
    final bool viewphone;
    final bool viewdate;

    if (jsonData['profile_image'] == null) {
      profileImage = "";
    } else {
      profileImage = jsonData['profile_image'];
    }
    jsonData['location'] == null
        ? location = ""
        : location = jsonData['location'];

    jsonData['department'] == null
        ? department = ""
        : department = jsonData['department'];
    jsonData['ssn'] == null ? ID = "" : ID = jsonData['ssn'];
    jsonData['phone']['value'] == null
        ? phone = ""
        : phone = jsonData['phone']['value'];

    jsonData['birthdate'] == null
        ? date = ""
        : date = jsonData['birthdate']['value'][0];

    jsonData['email']['value'] == null
        ? email = ""
        : email = jsonData['email']['value'];
    jsonData['government'] == null
        ? government = ""
        : government = jsonData['government'];
    jsonData['gender'] == null ? gender = "" : gender = jsonData['gender'];

    jsonData['name'] == null ? name = "" : name = jsonData['name'];

    jsonData['phone']['visible'] == null
        ? viewphone = false
        : viewphone = jsonData['phone']['visible'];

    jsonData['birthdate'] == null
        ? viewdate = false
        : viewdate = jsonData['birthdate']['visible'];

    jsonData['email']['visible'] == null
        ? viewemail = false
        : viewemail = jsonData['email']['visible'];
    return Profile(
      profileImage: profileImage,
      userName: jsonData['user_name'],
      name: name,
      gender: gender,
      government: government,
      email: email,
      phone: phone,
      date: date,
      ID: ID,
      viewemail: viewemail,
      viewphone: viewphone,
      viewdate: viewdate,
      department: department,
      location: location,
    );
  }
}
