class Login {
  final String accessToken;
  // final String refreshToken;

  Login({required this.accessToken});

  factory Login.fromJson(Map<String, dynamic> jsonData) {
    return Login(
      accessToken: jsonData['token'],
      // refreshToken: jsonData['refreshtoken'],
    );
  }
}
