// ignore_for_file: non_constant_identifier_names

import 'package:flutter/material.dart';
import 'package:rosheta_ui/Views/Languages/language_screen.dart';
import 'package:rosheta_ui/Views/profile/profile_screen.dart';
import 'package:rosheta_ui/Views/register/login_screen.dart';
import 'package:rosheta_ui/generated/l10n.dart';

class DataManager {
  // Private constructor to prevent instantiation
  DataManager._privateConstructor();

  // Singleton instance
  static final DataManager _instance = DataManager._privateConstructor();

  // Factory method to access the singleton instance
  factory DataManager() {
    return _instance;
  }

  // Your shared data
  int type = 1;
  String profile_image = '';
  String name = "";
  String username = "";
}

Drawer patient_drawer(context) {
  DataManager dataManager = DataManager();

  return Drawer(
    backgroundColor: Colors.white,
    child: Center(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          Center(
            child: Container(
              width: double.infinity,
              padding: const EdgeInsets.only(top: 40),
              color: Colors.cyan,
              child: Column(children: [
                Stack(children: [
                  dataManager.profile_image.isNotEmpty
                      ? CircleAvatar(
                          radius: 40.0,
                          backgroundImage:
                              NetworkImage(dataManager.profile_image),
                        )
                      : const CircleAvatar(
                          radius: 40.0,
                          backgroundImage: AssetImage('Images/profile.png'),
                        ),
                ]),
                Text(
                  dataManager.name,
                  style: const TextStyle(
                      fontSize: 25, color: Color.fromARGB(255, 1, 14, 15)),
                ),
                Text(
                  dataManager.username,
                  style: const TextStyle(
                      fontSize: 20, color: Color.fromARGB(255, 1, 14, 15)),
                ),
              ]),
            ),
          ),
          Container(
            color: Colors.black38,
            child: const SizedBox(
              height: 3,
            ),
          ),
          Center(
            child: Container(
              color: Colors.white,
              child: ListTile(
                leading: const Icon(
                  Icons.person_4,
                  size: 30,
                ),
                title: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      S.of(context).profile,
                      style: const TextStyle(fontSize: 25),
                    ),
                  ],
                ),
                onTap: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (c) => const ProfileScreen()));
                },
              ),
            ),
          ),
          Container(
            color: Colors.black38,
            child: const SizedBox(
              height: 3,
            ),
          ),
          Center(
            child: Container(
              color: Colors.white,
              child: ListTile(
                leading: const Icon(
                  Icons.qr_code,
                  size: 30,
                ),
                title: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      S.of(context).QrCode,
                      style: const TextStyle(fontSize: 25),
                    ),
                  ],
                ),
                onTap: () {},
              ),
            ),
          ),
          Container(
            color: Colors.black38,
            child: const SizedBox(
              height: 3,
            ),
          ),
          Container(
            color: Colors.white,
            child: ListTile(
              leading: const Icon(
                Icons.date_range,
                size: 30,
              ),
              title: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    S.of(context).Appointment,
                    style: const TextStyle(fontSize: 25),
                  ),
                ],
              ),
              onTap: () {
                // Handle button 1 tap
              },
            ),
          ),
          Container(
            color: Colors.black38,
            child: const SizedBox(
              height: 3,
            ),
          ),
          Container(
            color: Colors.white,
            child: ListTile(
              leading: const Icon(
                Icons.medical_services,
                size: 30,
              ),
              title: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    S.of(context).Chronic,
                    style: const TextStyle(fontSize: 25),
                  ),
                ],
              ),
              onTap: () {
                // Handle button 1 tap
              },
            ),
          ),
          Container(
            color: Colors.black38,
            child: const SizedBox(
              height: 3,
            ),
          ),
          Container(
            color: Colors.white,
            child: ListTile(
              leading: const Icon(
                Icons.file_copy,
                size: 30,
              ),
              title: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    S.of(context).Attachments,
                    style: const TextStyle(fontSize: 25),
                  ),
                ],
              ),
              onTap: () {
                // Handle button 1 tap
              },
            ),
          ),
          Container(
            color: Colors.black38,
            child: const SizedBox(
              height: 3,
            ),
          ),
          Container(
            color: Colors.white,
            child: ListTile(
              leading: const Icon(
                Icons.language,
                size: 30,
              ),
              title: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    S.of(context).langauege,
                    style: const TextStyle(fontSize: 25),
                  ),
                ],
              ),
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (c) => LanguageScreen()));

                // Handle button 1 tap
              },
            ),
          ),
          Container(
            color: Colors.black38,
            child: const SizedBox(
              height: 3,
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          Container(
            decoration: BoxDecoration(
              color: const Color.fromARGB(220, 218, 214, 214),
              borderRadius: BorderRadius.circular(
                  20.0), // Set the border radius for circular edges
            ),
            child: ListTile(
              leading: const Icon(
                Icons.logout,
                size: 30,
              ),
              title: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    S.of(context).Logout,
                    style: const TextStyle(
                      fontSize: 25,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ],
              ),
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (c) => const LoginScreen()));
              },
            ),
          ),
        ],
      ),
    ),
  );
}

Drawer doctor_drawer(context) {
  DataManager dataManager = DataManager();

  return Drawer(
    backgroundColor: Colors.white,
    child: Center(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          Center(
            child: Container(
              width: double.infinity,
              padding: const EdgeInsets.only(top: 40),
              color: Colors.cyan,
              child: Column(children: [
                Stack(children: [
                  dataManager.profile_image.isNotEmpty
                      ? CircleAvatar(
                          radius: 40.0,
                          backgroundImage:
                              NetworkImage(dataManager.profile_image),
                        )
                      : const CircleAvatar(
                          radius: 40.0,
                          backgroundImage: AssetImage('Images/profile.png'),
                        ),
                ]),
                Text(
                  dataManager.name,
                  style: const TextStyle(
                      fontSize: 25, color: Color.fromARGB(255, 1, 14, 15)),
                ),
                Text(
                  dataManager.username,
                  style: const TextStyle(
                      fontSize: 20, color: Color.fromARGB(255, 1, 14, 15)),
                ),
              ]),
            ),
          ),
          Container(
            color: Colors.black38,
            child: const SizedBox(
              height: 3,
            ),
          ),
          Center(
            child: Container(
              color: Colors.white,
              child: ListTile(
                leading: const Icon(
                  Icons.person_4,
                  size: 30,
                ),
                title: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      S.of(context).profile,
                      style: const TextStyle(fontSize: 25),
                    ),
                  ],
                ),
                onTap: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (c) => const ProfileScreen()));
                },
              ),
            ),
          ),
          Container(
            color: Colors.black38,
            child: const SizedBox(
              height: 3,
            ),
          ),
          Container(
            color: Colors.white,
            child: ListTile(
              leading: const Icon(
                Icons.medical_services,
                size: 30,
              ),
              title: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    S.of(context).examination,
                    style: const TextStyle(fontSize: 25),
                  ),
                ],
              ),
              onTap: () {
                // Handle button 1 tap
              },
            ),
          ),
          Container(
            color: Colors.black38,
            child: const SizedBox(
              height: 3,
            ),
          ),
          Container(
            color: Colors.white,
            child: ListTile(
              leading: const Icon(
                Icons.emergency,
                size: 30,
              ),
              title: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    S.of(context).Emergency,
                    style: const TextStyle(fontSize: 25),
                  ),
                ],
              ),
              onTap: () {
                // Handle button 1 tap
              },
            ),
          ),
          Container(
            color: Colors.black38,
            child: const SizedBox(
              height: 3,
            ),
          ),
          Container(
            color: Colors.white,
            child: ListTile(
              leading: const Icon(
                Icons.language,
                size: 30,
              ),
              title: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    S.of(context).langauege,
                    style: const TextStyle(fontSize: 25),
                  ),
                ],
              ),
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (c) => LanguageScreen()));

                // Handle button 1 tap
              },
            ),
          ),
          Container(
            color: Colors.black38,
            child: const SizedBox(
              height: 3,
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          Container(
            decoration: BoxDecoration(
              color: const Color.fromARGB(220, 218, 214, 214),
              borderRadius: BorderRadius.circular(
                  20.0), // Set the border radius for circular edges
            ),
            child: ListTile(
              leading: const Icon(
                Icons.logout,
                size: 30,
              ),
              title: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    S.of(context).Logout,
                    style: const TextStyle(
                      fontSize: 25,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ],
              ),
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (c) => const LoginScreen()));
              },
            ),
          ),
        ],
      ),
    ),
  );
}

Drawer lab_drawer(context) {
  DataManager dataManager = DataManager();

  return Drawer(
    backgroundColor: Colors.white,
    child: Center(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          Center(
            child: Container(
              width: double.infinity,
              padding: const EdgeInsets.only(top: 40),
              color: Colors.cyan,
              child: Column(children: [
                Stack(children: [
                  dataManager.profile_image.isNotEmpty
                      ? CircleAvatar(
                          radius: 40.0,
                          backgroundImage:
                              NetworkImage(dataManager.profile_image),
                        )
                      : const CircleAvatar(
                          radius: 40.0,
                          backgroundImage: AssetImage('Images/profile.png'),
                        ),
                ]),
                Text(
                  dataManager.name,
                  style: const TextStyle(
                      fontSize: 25, color: Color.fromARGB(255, 1, 14, 15)),
                ),
                Text(
                  dataManager.username,
                  style: const TextStyle(
                      fontSize: 20, color: Color.fromARGB(255, 1, 14, 15)),
                ),
              ]),
            ),
          ),
          Container(
            color: Colors.black38,
            child: const SizedBox(
              height: 3,
            ),
          ),
          Center(
            child: Container(
              color: Colors.white,
              child: ListTile(
                leading: const Icon(
                  Icons.person_4,
                  size: 30,
                ),
                title: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      S.of(context).profile,
                      style: const TextStyle(fontSize: 25),
                    ),
                  ],
                ),
                onTap: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (c) => const ProfileScreen()));
                },
              ),
            ),
          ),
          Container(
            color: Colors.black38,
            child: const SizedBox(
              height: 3,
            ),
          ),
          Center(
            child: Container(
              color: Colors.white,
              child: ListTile(
                leading: const Icon(
                  Icons.file_copy,
                  size: 30,
                ),
                title: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      S.of(context).uploadAttachment,
                      style: const TextStyle(fontSize: 25),
                    ),
                  ],
                ),
                onTap: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (c) => const ProfileScreen()));
                },
              ),
            ),
          ),
          Container(
            color: Colors.black38,
            child: const SizedBox(
              height: 3,
            ),
          ),
          Container(
            color: Colors.white,
            child: ListTile(
              leading: const Icon(
                Icons.language,
                size: 30,
              ),
              title: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    S.of(context).langauege,
                    style: const TextStyle(fontSize: 25),
                  ),
                ],
              ),
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (c) => LanguageScreen()));

                // Handle button 1 tap
              },
            ),
          ),
          Container(
            color: Colors.black38,
            child: const SizedBox(
              height: 3,
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          Container(
            decoration: BoxDecoration(
              color: const Color.fromARGB(220, 218, 214, 214),
              borderRadius: BorderRadius.circular(
                  20.0), // Set the border radius for circular edges
            ),
            child: ListTile(
              leading: const Icon(
                Icons.logout,
                size: 30,
              ),
              title: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    S.of(context).Logout,
                    style: const TextStyle(
                      fontSize: 25,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ],
              ),
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (c) => const LoginScreen()));
              },
            ),
          ),
        ],
      ),
    ),
  );
}

Drawer select_drawer(context) {
  DataManager dataManager = DataManager();
  if (dataManager.type == 1) return patient_drawer(context);
  if (dataManager.type == 2) return doctor_drawer(context);
  return lab_drawer(context);
}
