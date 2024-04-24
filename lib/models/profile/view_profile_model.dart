class ViewProfile {
  final String profileImage;
  final String userName;
  final String name;
  final String gender;
  final String government;
  final String email;
  final String phone;
  final String date;
  final String department;
  final String location;

  ViewProfile({
    required this.department,
    required this.profileImage,
    required this.userName,
    required this.name,
    required this.gender,
    required this.government,
    required this.email,
    required this.phone,
    required this.date,
    required this.location,
  });

  factory ViewProfile.fromJson(Map<String, dynamic> jsonData) {
    final String profileImage;
    final String name;
    final String gender;
    final String government;
    final String email;
    final String phone;
    final String date;
    final String department;
    final String location;
 

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
    jsonData['phone'] == null ? phone = "" : phone = jsonData['phone'];

    
    
      jsonData['birthdate'] == null
        ? date = ""
        : date = jsonData['birthdate'][0];

    jsonData['email'] == null ? email = "" : email = jsonData['email'];
    jsonData['government'] == null
        ? government = ""
        : government = jsonData['government'];
    jsonData['gender'] == null ? gender = "" : gender = jsonData['gender'];
    jsonData['name'] == null ? name = "" : name = jsonData['name'];

    return ViewProfile(
      profileImage: profileImage,
      userName: jsonData['user_name'],
      name: name,
      gender: gender,
      government: government,
      email: email,
      phone: phone,
      date: date,
      department: department,
      location: location,
    );
  }
}
