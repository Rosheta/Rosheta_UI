// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:rosheta_ui/Views/profile_view.dart';
import 'package:rosheta_ui/services/login_service.dart';
import 'package:rosheta_ui/generated/l10n.dart';
import 'package:rosheta_ui/Views/signup_screen.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreen createState() => _LoginScreen();
}

class _LoginScreen extends State<LoginScreen> {

  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  bool _obscureText = true;


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
                  Form(
                      key: _formKey,
                      child: Column(children: [
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
                          validator: (value) {
                            if (isValidEmail(value.toString())) return null;
                            return "Email must contain @";
                          },
                        ),
                        SizedBox(height: 15.0),
                        TextFormField(
                          controller: passwordController,
                          obscureText: _obscureText,
                          decoration: InputDecoration(
                              prefixIcon: Icon(Icons.lock),
                              suffixIcon: GestureDetector(
                                onTap: _togglePasswordVisibility,
                                child: Icon(
                                  _obscureText ? Icons.visibility_off : Icons.visibility,
                                ),
                              ),
                              border: OutlineInputBorder(),
                              labelText: S.of(context).password,
                              labelStyle: TextStyle(
                                color: Colors.cyan,
                              )),
                          validator: (value) {
                            return isValidPassword(value.toString());
                          },
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
                              if (_formKey.currentState!.validate()) {
                                _formKey.currentState?.save();
                                LoginApi loginapi = new LoginApi();
                                print('before request.....................');
                                bool tmp = await loginapi.login(emailController.text,passwordController.text);
                                if(tmp){
                                  Navigator.push(context,
                                      MaterialPageRoute(builder: (c) => ProfileView()));
                                }else{
                                  print('error');
                                }
                              }
                            },
                          ),
                        ),
                      ])),
                  SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(S.of(context).nothavingaccount),
                      TextButton(
                        child: Text(S.of(context).register),
                        onPressed: () => {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (c) => SignupScreen()))
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

  bool isValidEmail(String email) {
    // Use a regular expression to check if the email contains '@' and '.'
    // You can customize the regular expression based on your requirements
    final emailRegex =
        RegExp(r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$');
    return emailRegex.hasMatch(email);
  }

  dynamic isValidPassword(String password) {
    // Password must contain at least one uppercase letter, one lowercase letter,
    // one digit, one special character, and be at least 8 characters long
    final upperCaseRegex = RegExp(r'[A-Z]');
    final lowerCaseRegex = RegExp(r'[a-z]');
    final digitRegex = RegExp(r'[0-9]');
    final specialCharRegex = RegExp(r'[!@#$%^&*(),.?":{}|<>]');

    if (password.length < 8) {
      return "Password must contain more than 8 characters";
    } else if (!upperCaseRegex.hasMatch(password) ||
        !lowerCaseRegex.hasMatch(password)) {
      return "Password must contain upper and lower case";
    } else if (!digitRegex.hasMatch(password)) {
      return "Password must contain numbers";
    } else if (!specialCharRegex.hasMatch(password)) {
      return "Password must contain special characters";
    }
    return null;
  }

  void _togglePasswordVisibility() {
    setState(() {
      _obscureText = !_obscureText;
    });
  }
}
