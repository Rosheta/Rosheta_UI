// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:rosheta_ui/services/signup_service.dart';
import 'generated/l10n.dart';

class SignupScreen extends StatefulWidget {
  @override
  State<SignupScreen> createState() => _SignupState();
}

class _SignupState extends State<SignupScreen> {
  var NameController = TextEditingController();
  var ssnController = TextEditingController();
  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  TextEditingController birthDateController = TextEditingController();
  var phoneController = TextEditingController();

  bool _obscureText = true;
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          S.of(context).title,
          style: TextStyle(
            fontSize: 25,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        centerTitle: true,
        backgroundColor: Colors.cyan,
      ),
      body: Padding(
        padding: EdgeInsets.all(15.0),
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              children: [
                Text(
                  S.of(context).signup,
                  style: TextStyle(
                    color: Colors.cyan,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 15),
                Form(
                    key: _formKey,
                    child: Column(children: [
                      TextFormField(
                        controller: NameController,
                        keyboardType: TextInputType.name,
                        decoration: InputDecoration(
                            prefixIcon: Icon(Icons.person),
                            border: OutlineInputBorder(),
                            labelText: S.of(context).name,
                            labelStyle: TextStyle(
                              color: Colors.cyan,
                            )),
                        validator: (value) {
                          if (value.toString().length > 2) return null;
                          return "Enter your name";
                        },
                      ),
                      SizedBox(height: 10),
                      TextFormField(
                        controller: ssnController,
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                            prefixIcon: Icon(Icons.credit_card),
                            border: OutlineInputBorder(),
                            labelText: S.of(context).NationalId,
                            labelStyle: TextStyle(
                              color: Colors.cyan,
                            )),
                        validator: (value) {
                          if (value.toString().length != 14)
                            return "Enter your national id";
                          return null;
                        },
                      ),
                      SizedBox(height: 10),
                      TextFormField(
                        controller: emailController,
                        keyboardType: TextInputType.emailAddress,
                        decoration: InputDecoration(
                            prefixIcon: Icon(Icons.email),
                            border: OutlineInputBorder(),
                            labelText: S.of(context).email,
                            labelStyle: TextStyle(
                              color: Colors.cyan,
                            )),
                        validator: (value) {
                          if (isValidEmail(value.toString())) return null;
                          return "Email must contain @";
                        },
                      ),
                      SizedBox(height: 10),
                      TextFormField(
                        controller: passwordController,
                        keyboardType: TextInputType.visiblePassword,
                        obscureText: _obscureText,
                        decoration: InputDecoration(
                            prefixIcon: Icon(Icons.lock),
                            suffixIcon: GestureDetector(
                              onTap: _togglePasswordVisibility,
                              child: Icon(
                                _obscureText
                                    ? Icons.visibility_off
                                    : Icons.visibility,
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
                      SizedBox(height: 10),
                      TextFormField(
                        controller: phoneController,
                        keyboardType: TextInputType.phone,
                        decoration: InputDecoration(
                            prefixIcon: Icon(Icons.phone),
                            border: OutlineInputBorder(),
                            labelText: S.of(context).Phone,
                            labelStyle: TextStyle(
                              color: Colors.cyan,
                            )),
                        validator: (value) {
                          return isValidPhone(value.toString());
                        },
                      ),
                      SizedBox(height: 10),
                      TextFormField(
                        controller: birthDateController,
                        onTap: _datePicker,
                        decoration: InputDecoration(
                            prefixIcon: Icon(Icons.date_range),
                            border: OutlineInputBorder(),
                            labelText: S.of(context).birthDate,
                            labelStyle: TextStyle(
                              color: Colors.cyan,
                            )),
                      ),
                      SizedBox(height: 10),
                      Container(
                        width: double.infinity,
                        color: Colors.cyan,
                        child: MaterialButton(
                          child: Text(
                            S.of(context).SIGNUP,
                            style: TextStyle(
                              color: Colors.white,
                            ),
                          ),
                          onPressed: () async {
                            if (_formKey.currentState!.validate()) {
                              _formKey.currentState?.save();
                              print('before request.....................');
                              SignupApi signuprequest = new SignupApi();
                              bool check = await signuprequest.signup(
                                  email: emailController.text,
                                  password: passwordController.text,
                                  name: NameController.text,
                                  phone: phoneController.text,
                                  ssn: ssnController.text,
                                  birthdate: birthDateController.text);
                              if (check) {
                                // navigate to login page
                              } else {
                                print('Failed to signup');
                              }
                            }
                          },
                        ),
                      ),
                    ])),
                SizedBox(height: 5),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      S.of(context).havingaccount,
                    ),
                    TextButton(
                      onPressed: () {
                        // Navigate to login screen
                      },
                      child: Text(
                        S.of(context).LoginNow,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 5),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('We serve you with tender , care and love'),
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

  dynamic isValidPhone(String phone) {
    if (phone.length != 11) return "Phone must be 11 numbers";
    return null;
  }

  void _togglePasswordVisibility() {
    setState(() {
      _obscureText = !_obscureText;
    });
  }

  void _datePicker() async {
    DateTime? birthdate = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(1900),
        lastDate: DateTime(2100));

    if (birthdate != null) {
      setState(() {
        birthDateController.text = DateFormat('yyyy-MM-dd').format(birthdate);
      });
    }
  }
}
