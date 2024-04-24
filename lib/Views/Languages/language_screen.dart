import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rosheta_ui/Views/chat/friends_screen.dart';
import 'package:rosheta_ui/Views/search/search_screen.dart';
import 'package:rosheta_ui/drawer/drawers.dart';
import 'package:rosheta_ui/generated/l10n.dart';

class LocaleProvider extends ChangeNotifier {
  Locale _locale = const Locale('ar');

  Locale get locale => _locale;

  void updateLocale(Locale newLocale) {
    _locale = newLocale;
    notifyListeners();
  }
}

class LanguageScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var localeProvider = Provider.of<LocaleProvider>(context, listen: false);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.cyan,
        title: Text(
          S.of(context).title,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 25,
            color: Colors.white,
          ),
        ),
        actions: <Widget>[
          IconButton(
            icon: const Icon(Icons.message),
            iconSize: 30,
            color: Colors.white,
            onPressed: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (c) => const FriendsScreen()));
            },
          ),
          IconButton(
            icon: const Icon(Icons.search),
            iconSize: 30,
            color: Colors.white,
            onPressed: () {
              showSearch(
                  context: context,
                  // delegate to customize the search bar
                  delegate: SearchPeople());
            },
          ),
        ],
      ),
      drawer: select_drawer(context),
      body: Center(
        child: Column(
          children: <Widget>[
            const SizedBox(
              height: 3,
            ),
            Container(
              decoration: BoxDecoration(
                color: const Color.fromARGB(255, 209, 228, 243),
                borderRadius: BorderRadius.circular(
                    10.0), // Set the border radius for circular edges
              ),
              width: double.infinity,
              child: TextButton(
                onPressed: () {
                  localeProvider
                      .updateLocale(const Locale('en')); // Change to English
                },
                child: const Text(
                  'English',
                  style: TextStyle(fontSize: 25, color: Colors.black87),
                ),
              ),
            ),
            const SizedBox(
              height: 3,
            ),
            Container(
              decoration: BoxDecoration(
                color: const Color.fromARGB(255, 209, 228, 243),
                borderRadius: BorderRadius.circular(
                    10.0), // Set the border radius for circular edges
              ),
              width: double.infinity,
              child: TextButton(
                onPressed: () {
                  localeProvider
                      .updateLocale(const Locale('ar')); // Change to English
                },
                child: const Text(
                  'اللغة العربية',
                  style: TextStyle(fontSize: 25, color: Colors.black87),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
