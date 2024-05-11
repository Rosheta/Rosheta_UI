class User {
  final String profileImage;
  final String name;
  final bool flag;

  User({required this.profileImage, required this.name , required this.flag});

  factory User.fromJson(Map<String, dynamic> jsonData) {
    return User(
      profileImage: jsonData['image'],
      name: jsonData['name'],
      flag: true
    );
  }
}
