// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
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
                      labelText: S.of(context).password,
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
                      labelText: S.of(context).Phone,
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
                    onPressed: () {},
                    child: Text(
                      S.of(context).SIGNUP,
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
                      S.of(context).havingaccount,
                    ),
                    TextButton(
                      onPressed: () {},
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
