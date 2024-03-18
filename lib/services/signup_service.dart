import 'package:http/http.dart' as http;

class SignupApi {
  Future<bool> signup(
      {required email,
      required password,
      required name,
      required phone,
      required ssn,
      required birthdate,
      required type}) async {
    String url = 'http://127.0.0.1:8000/signup';
    try{
      http.Response response = await http.post(
        Uri.parse(url),
        headers: <String, String>{
          'Content-Type': 'application/json',
        },
        body: <String, dynamic>{
          'email': email,
          'password': password,
          'name': name,
          'phone': phone,
          'ssn': ssn,
          'birthdate': birthdate,
          'type': type,
        },
      );
      if(response.statusCode == 200 || response.statusCode == 201) {
        return true;
      }else
        return false;
    }
    catch(e){
      print("Exception: $e");
      return false;
    }
  }
}
