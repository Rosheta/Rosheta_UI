import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:rosheta_ui/Views/register/login_screen.dart';
import 'package:rosheta_ui/generated/l10n.dart';
import 'package:rosheta_ui/services/register/signup_service.dart';

class SignupPatientScreen extends StatefulWidget {
  @override
  State<SignupPatientScreen> createState() => _SignupPatientScreenState();
}

class _SignupPatientScreenState extends State<SignupPatientScreen> {
  final _formKey = GlobalKey<FormState>();
  var nameController = TextEditingController();
  var ssnController = TextEditingController();
  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  var birthDateController = TextEditingController();
  var phoneController = TextEditingController();
  String _selectedUserGender = "M";
  bool _obscureText = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(
            S.of(context).title,
            style: const TextStyle(
              fontSize: 25,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          centerTitle: true,
          backgroundColor: Colors.cyan,
        ),
        body: Padding(
            padding: const EdgeInsets.all(15.0),
            child: Center(
                child: SingleChildScrollView(
                    child: Column(
              children: [
                Text(
                  S.of(context).signup,
                  style: const TextStyle(
                    color: Colors.cyan,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 15),
                Form(
                  key: _formKey,
                  child: Column(children: [
                    buildTextFormField(emailController, S.of(context).email,
                        Icons.email, TextInputType.emailAddress, (value) {
                      if (isValidEmail(value.toString())) return null;
                      return S.of(context).enterValidEmail;
                    }),
                    const SizedBox(height: 10),
                    buildTextFormField(nameController, S.of(context).name,
                        Icons.person, TextInputType.name, (value) {
                      if (value.toString().length < 2) {
                        return S.of(context).enterYourName;
                      }
                      return null;
                    }),
                    const SizedBox(height: 10),
                    buildTextFormField(ssnController, S.of(context).NationalId,
                        Icons.person, TextInputType.number, (value) {
                      if (value.toString().length == 14) return null;
                      return S.of(context).enterYourNationalId;
                    }),
                    const SizedBox(height: 10),
                    DropdownButtonFormField(
                      value: _selectedUserGender,
                      onChanged: (newValue) {
                        setState(() {
                          _selectedUserGender = newValue.toString();
                        });
                      },
                      items: [
                        DropdownMenuItem(
                          value: 'M',
                          child: Text(S.of(context).male),
                        ),
                        DropdownMenuItem(
                          value: 'F', // Unique value for Doctor
                          child: Text(S.of(context).female),
                        ),
                      ],
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        contentPadding:
                            EdgeInsets.symmetric(horizontal: 10, vertical: 15),
                      ),
                    ),
                    const SizedBox(height: 10),
                    TextFormField(
                      controller: passwordController,
                      keyboardType: TextInputType.visiblePassword,
                      obscureText: _obscureText,
                      decoration: InputDecoration(
                          prefixIcon: const Icon(Icons.lock),
                          suffixIcon: GestureDetector(
                            onTap: _togglePasswordVisibility,
                            child: Icon(
                              _obscureText
                                  ? Icons.visibility_off
                                  : Icons.visibility,
                            ),
                          ),
                          border: const OutlineInputBorder(),
                          labelText: S.of(context).password,
                          labelStyle: const TextStyle(
                            color: Colors.cyan,
                          )),
                      validator: (value) {
                        return isValidPassword(value.toString());
                      },
                    ),
                    const SizedBox(height: 10),
                    buildTextFormField(phoneController, S.of(context).Phone,
                        Icons.phone, TextInputType.phone, (value) {
                      if (isValidPhone(value.toString()) == null) return null;
                      return S.of(context).enterValidPhone;
                    }),
                    const SizedBox(height: 10),
                    TextFormField(
                      controller: birthDateController,
                      onTap: _datePicker,
                      decoration: InputDecoration(
                          prefixIcon: const Icon(Icons.date_range),
                          border: const OutlineInputBorder(),
                          labelText: S.of(context).birthDate,
                          labelStyle: const TextStyle(
                            color: Colors.cyan,
                          )),
                    ),
                    const SizedBox(height: 10),
                    Container(
                      width: double.infinity,
                      color: Colors.cyan,
                      child: MaterialButton(
                        child: Text(
                          S.of(context).SIGNUP,
                          style: const TextStyle(
                            color: Colors.white,
                          ),
                        ),
                        onPressed: () async {
                          print("Validating: ${birthDateController.text}");

                          if (_formKey.currentState!.validate()) {
                            _formKey.currentState?.save();
                            SignupApi signuprequest = SignupApi();
                            String check = await signuprequest.signupPatient(
                              email: emailController.text,
                              password: passwordController.text,
                              name: nameController.text,
                              phone: phoneController.text,
                              ssn: ssnController.text,
                              birthdate: birthDateController.text,
                              gender: _selectedUserGender,
                            );
                            if (check == "true") {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (c) => const LoginScreen()));
                            } else {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content: Text('Error in signup'),
                                ),
                              );
                            }
                          }
                        },
                      ),
                    ),
                  ]),
                ),
                const SizedBox(height: 5),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      S.of(context).havingaccount,
                    ),
                    TextButton(
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (c) => const LoginScreen()));
                      },
                      child: Text(
                        S.of(context).LoginNow,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 5),
                const Row(
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
            )))));
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
      lastDate: DateTime(2100),
    );

    if (birthdate != null) {
      setState(() {
        birthDateController.text = DateFormat('yyyy-MM-dd','en_US').format(birthdate);
      });
    }
  }
}

TextFormField buildTextFormField(TextEditingController controller, String label,
    IconData icon, TextInputType type, Function Validator) {
  return TextFormField(
    controller: controller,
    keyboardType: type,
    autovalidateMode: AutovalidateMode.onUserInteraction,
    decoration: InputDecoration(
      prefixIcon: Icon(icon),
      border: const OutlineInputBorder(),
      labelText: label,
      labelStyle: const TextStyle(
        color: Colors.cyan,
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: BorderSide(color: Colors.red.shade900, width: 1),
      ),
    ),
    validator: (value) => Validator(value),
  );
}
