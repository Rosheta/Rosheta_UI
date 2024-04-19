import 'dart:io';
import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import 'package:rosheta_ui/Views/register/login_screen.dart';
import 'package:rosheta_ui/services/register/signup_service.dart';
import 'package:rosheta_ui/generated/l10n.dart';

class SignupLabScreen extends StatefulWidget {
  const SignupLabScreen({super.key});

  @override
  State<SignupLabScreen> createState() => _SignupLabScreenState();
}

class _SignupLabScreenState extends State<SignupLabScreen> {
  final List<String> governments = [
    'Cairo',
    'Alexandria',
    'Giza',
    'Qalyubia',
    'Beheira',
    'Matrouh',
    'Dakahlia',
    'Kafr El-Sheikh',
    'Gharbia',
    'Menoufia',
    'Damietta',
    'Port Said',
    'Ismailia',
    'Suez',
    'Sharqia',
    'North Sinai',
    'South Sinai',
    'Fayoum',
    'Beni Suef',
    'Minya',
    'Asyut',
    'New Valley',
    'Sohag',
    'Qena',
    'Luxor',
    'Aswan',
    'Red Sea',
  ];
  String _selectedGovernment = 'Cairo';
  final _formKey = GlobalKey<FormState>();
  var nameController = TextEditingController();
  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  var phoneController = TextEditingController();
  var positionController = TextEditingController();
  bool _obscureText = true;
  File? _selectedFile;
  FilePickerResult? filePickerResult;

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
                          child: Column(
                            children: [
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
                              buildTextFormField(phoneController, S.of(context).Phone,
                                  Icons.phone, TextInputType.phone, (value) {
                                if (isValidPhone(value.toString()) == null) return null;
                                return S.of(context).enterValidPhone;
                              }),
                              const SizedBox(height: 10),
                              DropdownButtonFormField(
                                value: _selectedGovernment,
                                onChanged: (newValue) {
                                  setState(() {
                                    _selectedGovernment = newValue.toString();
                                  });
                                },
                                items: governments.map((String government) {
                                  return DropdownMenuItem<String>(
                                    value: government,
                                    child: Text(government),
                                  );
                                }).toList(),
                                decoration: const InputDecoration(
                                  border: OutlineInputBorder(),
                                  contentPadding:
                                      EdgeInsets.symmetric(horizontal: 10, vertical: 15),
                                ),
                              ),
                              const SizedBox(height: 10),
                              buildTextFormField(
                                  positionController,
                                  S.of(context).positionController,
                                  Icons.location_on,
                                  TextInputType.streetAddress, (value) {
                                if (value.toString().length > 5) return null;
                                return S.of(context).enterclinicPosition;
                              }),
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
                              Row(
                                children: [
                                  ElevatedButton(
                                    onPressed: _selectFile,
                                    child: Text(S.of(context).uploadFile),
                                  ),
                                  const SizedBox(height: 10),
                                  Expanded(
                                      child: Text(
                                    _selectedFile != null
                                        ? '${_selectedFile?.path}'
                                        : 'No File Selected',
                                    style: const TextStyle(fontSize: 16),
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                  )),
                                ],
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
                                    if (_formKey.currentState!.validate() &&
                                        _selectedFile != null) {
                                      _formKey.currentState?.save();
                                      SignupApi signuprequest = SignupApi();
                                      String check = await signuprequest.signupLab(
                                          email: emailController.text,
                                          name: nameController.text,
                                          labPosition: positionController.text,
                                          password: passwordController.text,
                                          phone: phoneController.text,
                                          government: _selectedGovernment,
                                          selectedFile: _selectedFile!);
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
                      ]
                    )
              )
            )
      )
    );
  }

  bool isValidEmail(String email) {
    // Use a regular expression to check if the email contains '@' and '.'
    // You can customize the regular expression based on your requirements
    final emailRegex =
        RegExp(r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$');
    return emailRegex.hasMatch(email);
  }

  void _selectFile() async {
    // Open file picker to select a file
    FilePickerResult? result = await FilePicker.platform.pickFiles();
    if (result != null) {
      File file = File(result.files.single.path ?? '');
      setState(() {
        _selectedFile = file;
      });
    }
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
}



TextFormField buildTextFormField(TextEditingController controller, String label,
    IconData icon, TextInputType type, Function validator) {
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
    validator: (value) => validator(value),
  );
}
