import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:rosheta_ui/Views/edit_profile_screen.dart';
import 'package:rosheta_ui/Views/login_screen.dart';
import 'package:rosheta_ui/Views/profile_screen.dart';
import 'package:rosheta_ui/generated/l10n.dart';
import 'package:rosheta_ui/Views/signup_screen.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:rosheta_ui/models/profile_model.dart';

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
      locale: const Locale('en'),
      localizationsDelegates: const [
        S.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: S.delegate.supportedLocales,
      home: LoginScreen(),
      // home: EditBasicInfoScreen(
      //   user: Profile(
      //       userID: 'aa',
      //       userName: 'mo',
      //       phone: '010',
      //       profileImage: Uint8List.fromList([10, 20, 30, 40, 50]),
      //       email: 'mm@mm',
      //       date: '2003/03/25',
      //       ID: '19016506',
      //       viewemail: true,
      //       viewphone: true,
      //       viewID: true,
      //       viewdate: true),
      // ),
    );
  }
}
