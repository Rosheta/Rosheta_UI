class Profile {
  final String userName;
  final String email;
  final String phone;
  final String date;
  final String ID;

  Profile(
      {required this.userName,
      required this.email,
      required this.phone,
      required this.date,
      required this.ID});

  factory Profile.fromJson(Map<String, dynamic> jsonData) {
    return Profile(
        userName: jsonData['userName'],
        email: jsonData['email'],
        phone: jsonData['phone'],
        date: jsonData['date'],
        ID: jsonData['ID']);
  }
}
