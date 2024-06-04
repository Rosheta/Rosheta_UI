import 'dart:io';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:rosheta_ui/Views/search/search_screen.dart';
import 'package:rosheta_ui/Views/chat/friends_screen.dart';
import 'package:rosheta_ui/drawer/drawers.dart';
import 'package:rosheta_ui/generated/l10n.dart';
import 'package:rosheta_ui/models/profile/profile_model.dart';
import 'package:rosheta_ui/Views/profile/edit_profile_screen.dart';
import 'package:rosheta_ui/services/profile/Profile_service.dart';
import 'package:rosheta_ui/services/profile/change_pic_service.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _ProfileViewState createState() => _ProfileViewState();
}

class _ProfileViewState extends State<ProfileScreen> {
  late Future<Profile> _profileFuture;
  late File file;
  late String path;

  // create constructor to initialize the future
  void selectImage() async {
    FilePickerResult? res = await FilePicker.platform.pickFiles();
    if (res != null) {
      File newfile = File(res.files.single.path ?? '');
      setState(() {
        file = newfile;
      });
    }
    // ignore: unnecessary_new
    ChangePicApi changePicrequest = ChangePicApi();
    String s = await changePicrequest.changePic(profileImage: file);
    if (s != "") {
      setState(() {
        path = s;
      });
    }
  }

  Future<Profile> _fetchProfile() async {
    try {
      ProfileApi pa = ProfileApi();
      return await pa.featchProfile();
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
      body: FutureBuilder<Profile>(
        future: _profileFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            // return dumy(context, image);
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (snapshot.hasError) {
            // return dumy(context, image);
            return Center(
              child: Text('Error: ${snapshot.error}'),
            );
          } else {
            Profile pr = snapshot.data!;

            // image = pr.profileImage;

            return Container(
              color: const Color.fromARGB(255, 233, 255, 255),
              child: Padding(
                padding: const EdgeInsets.all(15.0),
                child: Center(
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        Stack(children: [
                          // ignore: unnecessary_null_comparison
                          pr.profileImage != ""
                              ? CircleAvatar(
                                  radius: 100.0,
                                  backgroundImage:
                                      NetworkImage(pr.profileImage,scale:2),
                                )
                              : const CircleAvatar(
                                  radius: 100.0,
                                  backgroundImage: NetworkImage(
                                      'https://cloudflare-ipfs.com/ipfs/Qmd3W5DuhgHirLHGVixi6V76LhCkZUz6pnFt5AJBiyvHye/avatar/912.jpg'),
                                ),
                          Positioned(
                            bottom: -5,
                            left: 160,
                            child: IconButton(
                                onPressed: () async {
                                  selectImage();
                                },
                                icon: const Icon(
                                  Icons.add_a_photo,
                                  size: 30,
                                )),
                          )
                        ]),
                        Text(
                          pr.userName,
                          style: const TextStyle(
                              fontSize: 15,
                              color: Color.fromARGB(255, 1, 14, 15)),
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
                        getCont(Icons.credit_card, pr.ID,
                            "${S.of(context).NationalId}:", pr.ID != ""),
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
                        const SizedBox(height: 40),
                        ElevatedButton(
                          onPressed: () async {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (c) =>
                                        EditBasicInfoScreen(user: pr)));
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color.fromARGB(
                                255, 159, 196, 196), // Background color
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(
                                  20.0), // Set the border radius for circular edges
                            ),
                          ),
                          child: Center(
                            child: SizedBox(
                              height:
                                  50, // Set the fixed height of the container
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  const Icon(
                                    Icons.settings,
                                    color: Colors.black,
                                    size: 35.0,
                                  ),
                                  const SizedBox(width: 25),
                                  Text(
                                    S.of(context).editInfor,
                                    style: const TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 20,
                                        color: Colors.black),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: 20),
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
