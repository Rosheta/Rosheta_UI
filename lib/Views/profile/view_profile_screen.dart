// ignore_for_file: camel_case_types, unnecessary_null_comparison
import 'package:flutter/material.dart';
import 'package:rosheta_ui/Views/chat/chat_screen.dart';
import 'package:rosheta_ui/Views/chat/friends_screen.dart';
import 'package:rosheta_ui/Views/search/search_screen.dart';
import 'package:rosheta_ui/drawer/drawers.dart';
import 'package:rosheta_ui/generated/l10n.dart';
import 'package:rosheta_ui/models/profile/view_profile_model.dart';
import 'package:rosheta_ui/services/chat/chat_service.dart';
import 'dart:io';
import 'package:rosheta_ui/services/profile/view_profile_service.dart';

class ViewProfileScreen extends StatefulWidget {
  final String userID; // Define a property to hold the user object
  const ViewProfileScreen({super.key, required this.userID});
  @override
  // ignore: library_private_types_in_public_api
  _viewProfileViewState createState() => _viewProfileViewState();
}

class _viewProfileViewState extends State<ViewProfileScreen> {
  late Future<ViewProfile> _profileFuture;
  late ViewProfile pr;
  File imageFile = File('Images/profile.png');
  Visibility getCont(IconData icon, dynamic st, String text, bool vis) {
    return Visibility(
      visible: vis,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          const SizedBox(height: 10),
          Row(children: [
            Text(
              text.toString(),
              style: const TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
          ]),
          Container(
            decoration: BoxDecoration(
              color: const Color.fromARGB(255, 159, 196, 196),
              borderRadius: BorderRadius.circular(
                  10.0), // Set the border radius for circular edges
            ),
            child: SizedBox(
              height: 50, // Set the fixed width of the container
              child: Row(
                children: [
                  const SizedBox(width: 5),
                  Icon(
                    icon,
                    color: Colors.black,
                    size: 35.0,
                  ),
                  const SizedBox(width: 10),
                  Text(
                    st.toString(),
                    style: const TextStyle(
                      fontSize: 20,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Future<ViewProfile> _fetchProfile() async {
    try {
      viewProfileApi vp = viewProfileApi();
      return await vp.viewProfile(userId: widget.userID);
    } catch (e) {
      // Handle any errors that occur during the data fetching process
      throw Exception('Failed to fetch profile');
    }
  }

  @override
  Widget build(BuildContext context) {
    _profileFuture = _fetchProfile();

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
      body: FutureBuilder<ViewProfile>(
        future: _profileFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (snapshot.hasError) {
            return Center(
              child: Text('Error: ${snapshot.error}'),
            );
          } else {
            pr = snapshot.data!;
            return Container(
              color: const Color.fromARGB(255, 233, 255, 255),
              child: Padding(
                padding: const EdgeInsets.all(15.0),
                child: Center(
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        Stack(children: [
                          pr.profileImage.isNotEmpty
                              ? CircleAvatar(
                                  radius: 100.0,
                                  backgroundImage:
                                      NetworkImage(pr.profileImage),
                                )
                              : const CircleAvatar(
                                  radius: 100.0,
                                  backgroundImage:
                                      AssetImage('Images/profile.png'),
                                ),
                        ]),
                        Text(
                          pr.userName,
                          style: const TextStyle(
                              fontSize: 15,
                              color: Color.fromARGB(255, 1, 14, 15)),
                        ),
                        const SizedBox(height: 15),
                        TextButton(
                          onPressed: () async {
                            ChatApi chatApi = ChatApi();
                            String chatID =
                                await chatApi.startChat(widget.userID);

                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (c) => ChatScreen(
                                          userIdSecondPerson: widget.userID,
                                          name: pr.userName,
                                          chatId: chatID,
                                        )));
                          },
                          child: Container(
                            decoration: BoxDecoration(
                              color: const Color.fromARGB(255, 25, 155, 155),
                              borderRadius: BorderRadius.circular(
                                  10.0), // Set the border radius for circular edges
                            ),
                            child: const SizedBox(
                              height: 50,
                              width: 200,
                              child: Row(
                                children: [
                                  SizedBox(width: 10),
                                  Icon(Icons.message,
                                      size: 20, color: Colors.black),
                                  SizedBox(width: 10),
                                  Center(
                                      child: Text(
                                    'Send Message',
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold),
                                  ))
                                ],
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: 10),
                        Text(
                          pr.name,
                          style: const TextStyle(
                              fontSize: 25.5,
                              color: Color.fromARGB(255, 1, 14, 15)),
                        ),
                        const SizedBox(height: 20),
                        getCont(
                            Icons.medical_services,
                            pr.department,
                            "${S.of(context).department}:",
                            pr.department != ""),
                        getCont(Icons.email, pr.email,
                            "${S.of(context).email}:", pr.email != ""),
                        getCont(Icons.phone, pr.phone,
                            "${S.of(context).Phone}:", pr.phone != ""),
                        getCont(
                            Icons.location_city,
                            pr.government,
                            "${S.of(context).government}:",
                            pr.government != ""),
                        getCont(Icons.place, pr.location,
                            "${S.of(context).location}:", pr.location != ""),
                        pr.date != ""
                            ? getCont(
                                Icons.date_range,
                                pr.date.substring(0, 10),
                                "${S.of(context).birthDate}:",
                                pr.date != "")
                            : getCont(Icons.date_range, pr.date,
                                "${S.of(context).birthDate}:", false),
                        pr.gender == 'm'
                            ? getCont(Icons.male, S.of(context).male,
                                "${S.of(context).gender}:", pr.gender != "")
                            : getCont(Icons.female, S.of(context).female,
                                "${S.of(context).gender}:", pr.gender != ""),
                        const SizedBox(height: 10),
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
              ),
            );
          }
        },
      ),
    );
  }
}
