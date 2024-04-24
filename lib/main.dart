import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:rosheta_ui/Views/Languages/language_screen.dart';
import 'package:rosheta_ui/Views/patient_medical_data/Chronic_screen.dart';
import 'package:rosheta_ui/Views/profile/profile_screen.dart';
import 'package:rosheta_ui/Views/register/login_screen.dart';
import 'package:rosheta_ui/Views/search/search_screen.dart';
import 'package:rosheta_ui/generated/l10n.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding
      .ensureInitialized(); // Ensure plugin services are initialized
  await dotenv.load(fileName: ".env");
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => SearchProvider()),
        ChangeNotifierProvider(create: (context) => LocaleProvider()),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    var localeProvider = Provider.of<LocaleProvider>(context);

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      locale: localeProvider.locale, // Use the locale from LocaleProvider
      localizationsDelegates: const [
        S.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: S.delegate.supportedLocales,
      home: ChronicDiseaseListScreen(),
    );
  }
}
