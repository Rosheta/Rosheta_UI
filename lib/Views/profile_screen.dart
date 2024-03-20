import 'package:flutter/material.dart';
import 'package:rosheta_ui/generated/l10n.dart';
import 'package:rosheta_ui/models/profile_model.dart';
import 'package:rosheta_ui/screens/edit_profile_screen.dart';
import 'package:rosheta_ui/services/Profile_service.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  _ProfileViewState createState() => _ProfileViewState();
}

class _ProfileViewState extends State<ProfileScreen> {
  late Future<Profile> _profileFuture;

  // create constructor to initialize the future

  Future<Profile> _fetchProfile() async {
    try {
      ProfileApi pa = ProfileApi();
      return await pa.featchProfile();
    } catch (e) {
      // Handle any errors that occur during the data fetching process
      print('Error fetching profile: $e');
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
            icon: Icon(Icons.message),
            iconSize: 30,
            color: Colors.white,
            onPressed: () {
              // Handle icon1 onPressed action
            },
          ),
          IconButton(
            icon: Icon(Icons.search),
            iconSize: 30,
            color: Colors.white,
            onPressed: () {
              // Handle icon2 onPressed action
            },
          ),
          IconButton(
            icon: Icon(Icons.menu),
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
            // return dumy(context);
            return Center(
              child: CircularProgressIndicator(),
            );
          } else if (snapshot.hasError) {
            // return dumy(context);
            return Center(
              child: Text('Error: ${snapshot.error}'),
            );
          } else {
            Profile pr = snapshot.data!;
            return Container(
              color: const Color.fromARGB(255, 233, 255, 255),
              child: Padding(
                padding: EdgeInsets.all(15.0),
                child: Center(
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        const CircleAvatar(
                          radius: 100.0,
                          backgroundImage: AssetImage('Images/profile.png'),
                        ),
                        Text(
                          pr.userName,
                          style: const TextStyle(
                              fontSize: 25.5,
                              color: Color.fromARGB(255, 1, 14, 15)),
                        ),
                        const SizedBox(height: 30),
                        getCont(
                            Icons.email, pr.email, S.of(context).email + ":"),
                        const SizedBox(height: 10),
                        getCont(
                            Icons.phone, pr.phone, S.of(context).Phone + ":"),
                        const SizedBox(height: 10),
                        getCont(
                          Icons.date_range,
                          pr.date.substring(0, 10),
                          S.of(context).UserbirthDate + ":",
                        ),
                        const SizedBox(height: 10),
                        getCont(Icons.credit_card, pr.ID,
                            S.of(context).NationalId + ":"),
                        const SizedBox(height: 40),
                        ElevatedButton(
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (c) =>
                                        EditBasicInfoScreen(user: pr)));
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Color.fromARGB(
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
                                SizedBox(width: 30),
                                Icon(
                                  Icons.settings,
                                  color: Colors.black,
                                  size: 35.0,
                                ),
                                SizedBox(width: 25),
                                Text(
                                  S.of(context).editInfor,
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 20,
                                      color: Colors.black),
                                ),
                              ],
                            ),
                          ),
                        ),
                        SizedBox(height: 20),
                        Row(
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
          color: Color.fromARGB(255, 159, 196, 196),
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

Container dumy(context) {
  String da = "03-04-2017:022150";
  return Container(
    color: const Color.fromARGB(255, 233, 255, 255),
    child: Padding(
      padding: EdgeInsets.all(15.0),
      child: Center(
        child: SingleChildScrollView(
          child: Column(
            children: [
              const CircleAvatar(
                radius: 100.0,
                backgroundImage: AssetImage('Images/profile.png'),
              ),
              Text(
                "Mohamed Mostafa Ibrahim",
                style: const TextStyle(
                    fontSize: 25.5, color: Color.fromARGB(255, 1, 14, 15)),
              ),
              const SizedBox(height: 30),
              getCont(
                  Icons.email, "hamomemo@gmail.com", S.of(context).email + ":"),
              const SizedBox(height: 10),
              getCont(Icons.phone, "01032901480", S.of(context).Phone + ":"),
              const SizedBox(height: 10),
              getCont(
                Icons.date_range,
                da.substring(0, 10),
                S.of(context).UserbirthDate + ":",
              ),
              const SizedBox(height: 10),
              getCont(Icons.credit_card, "301071202023662",
                  S.of(context).NationalId + ":"),
              const SizedBox(height: 40),
              ElevatedButton(
                onPressed: () {
                  Profile pro = Profile(
                      userName: "userName",
                      email: "email",
                      phone: "phone",
                      date: "2024/10/15",
                      ID: "ID");
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (c) => EditBasicInfoScreen(user: pro)));
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor:
                      Color.fromARGB(255, 159, 196, 196), // Background color
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(
                        20.0), // Set the border radius for circular edges
                  ),
                ),
                child: SizedBox(
                  height: 50, // Set the fixed height of the container
                  child: Row(
                    children: [
                      SizedBox(width: 30),
                      Icon(
                        Icons.settings,
                        color: Colors.black,
                        size: 35.0,
                      ),
                      SizedBox(width: 25),
                      Text(
                        S.of(context).editInfor,
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 20,
                            color: Colors.black),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 20),
              Row(
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
