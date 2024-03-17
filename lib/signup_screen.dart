// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class SignupScreen extends StatefulWidget {
  @override
  State<SignupScreen> createState() => _SignupState();
}

class _SignupState extends State<SignupScreen> {
  var firstNameController = TextEditingController();
  var lastNameController = TextEditingController();
  var ssnController = TextEditingController();
  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  TextEditingController birthDateController = TextEditingController();
  var phoneController = TextEditingController();

  bool _obscureText = true;

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'ROSHETA',
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
                // Text(
                //   'Signup',
                //   style: TextStyle(
                //     color: Colors.cyan,
                //     fontSize: 20,
                //     fontWeight: FontWeight.bold,
                //   ),
                // ),
                // SizedBox(height: 15),
                TextFormField(
                  controller: firstNameController,
                  keyboardType: TextInputType.name,
                  decoration: InputDecoration(
                      prefixIcon: Icon(Icons.person),
                      border: OutlineInputBorder(),
                      labelText: 'First Name',
                      labelStyle: TextStyle(
                        color: Colors.cyan,
                      )),
                ),
                SizedBox(height: 10),
                TextFormField(
                  controller: lastNameController,
                  keyboardType: TextInputType.name,
                  decoration: InputDecoration(
                      prefixIcon: Icon(Icons.person),
                      border: OutlineInputBorder(),
                      labelText: 'Last Name',
                      labelStyle: TextStyle(
                        color: Colors.cyan,
                      )),
                ),
                SizedBox(height: 10),
                TextFormField(
                  controller: ssnController,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                      prefixIcon: Icon(Icons.credit_card),
                      border: OutlineInputBorder(),
                      labelText: 'National ID',
                      labelStyle: TextStyle(
                        color: Colors.cyan,
                      )),
                ),
                SizedBox(height: 10),
                TextFormField(
                  controller: emailController,
                  keyboardType: TextInputType.emailAddress,
                  decoration: InputDecoration(
                      prefixIcon: Icon(Icons.email),
                      border: OutlineInputBorder(),
                      labelText: 'Email Address',
                      labelStyle: TextStyle(
                        color: Colors.cyan,
                      )),
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
                        child : Icon(_obscureText ? Icons.visibility_off : Icons.visibility,),
                      ),
                      border: OutlineInputBorder(),
                      labelText: 'Password',
                      labelStyle: TextStyle(
                        color: Colors.cyan,
                      )),
                ),
                SizedBox(height: 10),
                TextFormField(
                  controller: phoneController,
                  keyboardType: TextInputType.phone,
                  decoration: InputDecoration(
                      prefixIcon: Icon(Icons.phone),
                      border: OutlineInputBorder(),
                      labelText: 'Phonenumber',
                      labelStyle: TextStyle(
                        color: Colors.cyan,
                      )),
                ),
                SizedBox(height: 10),
                TextFormField(
                  controller: birthDateController,
                  onTap: _datePicker,
                  decoration: InputDecoration(
                      prefixIcon: Icon(Icons.date_range),
                      border: OutlineInputBorder(),
                      labelText: 'Select Birth Date',
                      labelStyle: TextStyle(
                        color: Colors.cyan,
                      )),
                ),
                SizedBox(height: 10),
                Container(
                  width: double.infinity,
                  color: Colors.cyan,
                  child: MaterialButton(
                    onPressed: () {},
                    child: Text(
                      'SIGNUP',
                      style: TextStyle(
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 5),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Have an account?',
                    ),
                    TextButton(
                      onPressed: () {},
                      child: Text(
                        'Login Now',
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 5),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('We serve you with tender , care and love'),
                    Icon(Icons.favorite , color: Colors.red,)
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
