import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:rosheta_ui/Views/profile/edit_profile_screen.dart';
import 'package:rosheta_ui/Views/profile/profile_screen.dart';
import 'package:rosheta_ui/Views/register/login_screen.dart';
import 'package:rosheta_ui/generated/l10n.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:rosheta_ui/models/profile/profile_model.dart';

void main() async {
  WidgetsFlutterBinding
      .ensureInitialized(); // Ensure plugin services are initialized
  await dotenv.load(fileName: ".env");
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      locale: const Locale('ar'),
      localizationsDelegates: const [
        S.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: S.delegate.supportedLocales,
      //   home: EditBasicInfoScreen(
      //     user: Profile(
      //       profileImage: "",
      //       userName: "Mo13sal",
      //       name: 'Mohamed Salama',
      //       gender: 'm',
      //       government: 'Alexandria',
      //       email: '',
      //       phone: 'phone',
      //       date: '',
      //       ID: 'id',
      //       viewemail: false,
      //       viewphone: false,
      //       viewdate: true,
      //       department: "Otology",
      //       location: 'true',
      //     ),
      //   ),
      // );

      home: LoginScreen(),
    );
  }
}
