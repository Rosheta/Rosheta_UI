// ignore_for_file: must_be_immutable

import 'dart:convert';

// import 'package:rosheta_ui/signup_screen.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:rosheta_ui/models/login_model.dart';
import 'package:rosheta_ui/services/login_service.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:rosheta_ui/generated/l10n.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({super.key});

  var emailController = TextEditingController();
  var passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.cyan,
        title: Text(
          S.of(context).title,
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 25,
            color: Colors.white,
          ),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: EdgeInsets.all(25.0),
        child: Center(
          child: SingleChildScrollView(
            child: Container(
              width: double.infinity,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    S.of(context).login,
                    style: TextStyle(fontSize: 40.0, color: Colors.cyan),
                  ),
                  SizedBox(height: 25.0),
                  TextFormField(
                    controller: emailController,
                    keyboardType: TextInputType.emailAddress,
                    decoration: InputDecoration(
                      prefixIcon: Icon(Icons.email),
                      labelText: S.of(context).email,
                      labelStyle: TextStyle(
                        color: Colors.cyan,
                      ),
                      border: OutlineInputBorder(),
                    ),
                  ),
                  SizedBox(height: 15.0),
                  TextFormField(
                    controller: passwordController,
                    obscureText: true,
                    decoration: InputDecoration(
                        prefixIcon: Icon(Icons.lock),
                        suffixIcon: Icon(Icons.remove_red_eye),
                        border: OutlineInputBorder(),
                        labelText: S.of(context).password,
                        labelStyle: TextStyle(
                          color: Colors.cyan,
                        )),
                  ),
                  SizedBox(height: 30),
                  Container(
                    width: 150,
                    child: MaterialButton(
                      color: Colors.cyan,
                      child: Text(
                        S.of(context).LOGIN,
                        style: TextStyle(color: Colors.white),
                      ),
                      onPressed: () async {
                        LoginApi loginapi = new LoginApi();
                        print('before request.....................');
                        await loginapi.login(emailController.text, passwordController.text);
                      },
                    ),
                  ),
                  SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(S.of(context).nothavingaccount),
                      TextButton(
                        child: Text(S.of(context).register),
                        onPressed: () => {
                          // Navigator.push(
                          //     context,
                          //     MaterialPageRoute(
                          //         builder: (context) => SignupScreen()))
                        },
                      )
                    ],
                  ),
                  SizedBox(height: 5),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.favorite,
                        color: Colors.red,
                      ),
                      Text(' We serve you with tender , care and love '),
                      Icon(
                        Icons.favorite,
                        color: Colors.red,
                      )
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Future<void> _login(BuildContext context) async {
    // Simulate login request
    var response = await http.post(
      Uri.parse('https://127.0.0.1:5000/login'),
      body: {
        'email': emailController.text,
        'password': passwordController.text
      },
    );

    if (response.statusCode == 200) {
      print(response.body);
      var accessToken = response.body;
      var refreshToken = response.body;

      var prefs = await SharedPreferences.getInstance();
      await prefs.setString('access_token', accessToken);
      await prefs.setString('refresh_token', refreshToken);

      // Navigate to profile screen
      // Navigator.push(
      //   context,
      //   MaterialPageRoute(builder: (context) => ProfileScreen()),
      // );
    } else {
      // Handle login error
      print('Login failed');
    }
  }
}
