import 'package:flutter/material.dart';
import 'package:rosheta_ui/Views/register/login_screen.dart';
import 'package:rosheta_ui/Views/register/signup_doctor_screen.dart';
import 'package:rosheta_ui/Views/register/signup_patient_screen.dart';
import '../../generated/l10n.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupState();
}

class _SignupState extends State<SignupScreen> {

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
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
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
                TextButton(
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (c) =>  SignupPatientScreen()));
                      },
                      style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all<Color>(Colors.cyan),
                      ),
                      child: Text(
                        S.of(context).Patient,
                        style: const TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold
                        ),
                      ),
                    ),
                const SizedBox(height: 15),
                TextButton(
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (c) =>  SignupDoctorScreen()));
                      },
                      style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all<Color>(Colors.cyan),
                      ),
                      child: Text(
                        S.of(context).Doctor,
                        style: const TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
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
            ),
          ),
        ),
    );
  }
}
