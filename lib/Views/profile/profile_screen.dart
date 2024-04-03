import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:rosheta_ui/Views/search/search_screen.dart';
import 'package:rosheta_ui/Views/chat/friends_screen.dart';
import 'package:rosheta_ui/generated/l10n.dart';
import 'package:rosheta_ui/models/profile/profile_model.dart';
import 'package:rosheta_ui/Views/profile/edit_profile_screen.dart';
import 'package:rosheta_ui/services/profile/Profile_service.dart';
import 'package:image_picker/image_picker.dart';
import 'package:rosheta_ui/services/profile/change_pic_service.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _ProfileViewState createState() => _ProfileViewState();
}

class _ProfileViewState extends State<ProfileScreen> {
  late Future<Profile> _profileFuture;
  // create constructor to initialize the future
  Uint8List image = Uint8List.fromList([]);
  void selectImage() async {
    Uint8List img = await pickImage(ImageSource.gallery);
    print("object");
    print(img);
    setState(() {
      image = img;
    });
    print(image);
    // ignore: unnecessary_new
    changePicApi changePicrequest = changePicApi();
    print(await changePicrequest.changePic(profileImage: img));
  }

  pickImage(ImageSource source) async {
    final ImagePicker impicker = ImagePicker();
    XFile? file = await impicker.pickImage(source: source);
    if (file != null) {
      return await file.readAsBytes();
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

  Container dumy(context, Uint8List ima) {
    String da = "03-04-2017:022150";
    Profile pr = Profile(
        profileImage: ima,
        userName: "userName",
        email: "email",
        phone: "phone",
        date: "1901-02-03",
        ID: "ID",
        viewemail: true,
        viewphone: true,
        viewdate: true,
        viewID: true);
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
                  ima != null
                      ? CircleAvatar(
                          radius: 100.0,
                          backgroundImage: MemoryImage(ima),
                        )
                      : const CircleAvatar(
                          radius: 100.0,
                          backgroundImage: AssetImage('Images/profile.png'),
                        ),
                  Positioned(
                    bottom: -5,
                    left: 160,
                    child: IconButton(
                        onPressed: () async {
                          selectImage();
                          // ignore: unnecessary_new
                          changePicApi changePicrequest = new changePicApi();
                          await changePicrequest.changePic(profileImage: ima);
                        },
                        icon: const Icon(
                          Icons.add_a_photo,
                          size: 30,
                        )),
                  )
                ]),
                const Text(
                  "Mohamed Mostafa Ibrahim",
                  style: TextStyle(
                      fontSize: 25.5, color: Color.fromARGB(255, 1, 14, 15)),
                ),
                const SizedBox(height: 30),
                getCont(Icons.email, "hamomemo@gmail.com",
                    "${S.of(context).email}:"),
                const SizedBox(height: 10),
                getCont(Icons.phone, "01032901480", "${S.of(context).Phone}:"),
                const SizedBox(height: 10),
                getCont(
                  Icons.date_range,
                  da.substring(0, 10),
                  "${S.of(context).UserbirthDate}:",
                ),
                const SizedBox(height: 10),
                getCont(Icons.credit_card, "301071202023662",
                    "${S.of(context).NationalId}:"),
                const SizedBox(height: 40),
                ElevatedButton(
                  onPressed: () async {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (c) => EditBasicInfoScreen(user: pr)));
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color.fromARGB(
                        255, 159, 196, 196), // Background color
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(
                          20.0), // Set the border radius for circular edges
                    ),
                  ),
                  child: SizedBox(
                    height: 50, // Set the fixed height of the container
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
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (c) => const FriendsScreen()));
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
          IconButton(
            icon: const Icon(Icons.menu),
            iconSize: 30,
            color: Colors.white,
            onPressed: () {
              // Handle icon3 onPressed action
            },
          ),
        ],
      ),
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
            //image = pr.profileImage;

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
                          image.isNotEmpty
                              ? CircleAvatar(
                                  radius: 100.0,
                                  backgroundImage: MemoryImage(image),
                                )
                              : const CircleAvatar(
                                  radius: 100.0,
                                  backgroundImage:
                                      AssetImage('Images/profile.png'),
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
                              fontSize: 25.5,
                              color: Color.fromARGB(255, 1, 14, 15)),
                        ),
                        const SizedBox(height: 30),
                        getCont(
                            Icons.email, pr.email, "${S.of(context).email}:"),
                        const SizedBox(height: 10),
                        getCont(
                            Icons.phone, pr.phone, "${S.of(context).Phone}:"),
                        const SizedBox(height: 10),
                        getCont(
                          Icons.date_range,
                          pr.date.substring(0, 10),
                          "${S.of(context).UserbirthDate}:",
                        ),
                        const SizedBox(height: 10),
                        getCont(Icons.credit_card, pr.ID,
                            "${S.of(context).NationalId}:"),
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
                          child: SizedBox(
                            height: 50, // Set the fixed height of the container
                            child: Row(
                              children: [
                                const SizedBox(width: 30),
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

Column getCont(IconData icon, dynamic st, String text) {
  return Column(
    mainAxisAlignment: MainAxisAlignment.start,
    children: [
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
  );
}
