// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:rosheta_ui/signup_screen.dart';

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
          'ROSHETA',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 25,
            color: Colors.white, 
          ),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: EdgeInsets.all(2.0),
        child: Container(
          width: double.infinity,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Login',
                style: TextStyle(fontSize: 40.0, color: Colors.cyan),
              ),
              SizedBox(height: 25.0),
              TextFormField(
                controller: emailController,
                keyboardType: TextInputType.emailAddress,
                decoration: InputDecoration(
                  prefixIcon: Icon(Icons.email),
                  labelText: 'Email Address',
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
                    labelText: 'Password',
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
                    'LOGIN',
                    style: TextStyle(color: Colors.white),
                  ),
                  onPressed: login,
                ),
              ),
              SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('Don\'t have account?'),
                  TextButton(
                    child: Text('Register'),
                    onPressed: () => {
                      Navigator.push(
                        context, 
                        MaterialPageRoute(builder: (context) => SignupScreen()
                        )
                      )
                    },
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  void login() {
    print(emailController.text);
    print(passwordController.text);
  }
}
