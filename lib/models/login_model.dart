class Login {
  final String accessToken;
  final String refreshToken;

  Login({required this.accessToken, required this.refreshToken});

  factory Login.fromJson(Map<String, dynamic> jsonData) {
    return Login(
      accessToken: jsonData['accesstoken'],
      refreshToken: jsonData['refreshtoken'],
    );
  }
}
