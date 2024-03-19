import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:rosheta_ui/generated/l10n.dart';
import 'package:rosheta_ui/models/profile_model.dart';
import 'package:rosheta_ui/services/Profile_service.dart';

class ProfileView extends StatefulWidget {
  const ProfileView({Key? key}) : super(key: key);

  @override
  _ProfileViewState createState() => _ProfileViewState();
}

class _ProfileViewState extends State<ProfileView> {
  late Future<Profile> _profileFuture;

  @override
  Future<void> initState() async {
    super.initState();
    ProfileApi pa = new ProfileApi();
    _profileFuture = await pa.fetchProfile();
  }

  @override
  Widget build(BuildContext context) {
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
        centerTitle: true,
      ),
      body: FutureBuilder<Profile>(
        future: _profileFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else if (snapshot.hasError) {
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
                        getCont(Icons.email, pr.email, S.of(context).email),
                        const SizedBox(height: 10),
                        getCont(Icons.phone, pr.phone, S.of(context).Phone),
                        const SizedBox(height: 10),
                        getCont(
                          Icons.date_range,
                          pr.date,
                          S.of(context).UserbirthDate,
                        ),
                        const SizedBox(height: 10),
                        getCont(
                            Icons.credit_card, pr.ID, S.of(context).NationalId),
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

// class ProfileView extends StatelessWidget {
//   const ProfileView({super.key});
//   final Color iconColor = const Color.fromARGB(255, 9, 19, 19);

//   @override
//   Widget build(BuildContext context) {
// return Scaffold(
//   appBar: AppBar(
//     backgroundColor: Colors.cyan,
//     title: Text(
//       S.of(context).title,
//       style: const TextStyle(
//         fontWeight: FontWeight.bold,
//         fontSize: 25,
//         color: Colors.white,
//       ),
//     ),
//     centerTitle: true,
//   ),
//       body: Container(
//         color: const Color.fromARGB(
//             255, 233, 255, 255), // Set your desired background color here
//         child: Padding(
//           padding: EdgeInsets.all(15.0),
//           child: Center(
//             child: SingleChildScrollView(
//               child: Column(
// children: [
//   const CircleAvatar(
//     radius: 100.0,
//     backgroundImage: AssetImage('Images/profile.png'),
//   ),
//   const Text(
//     "Mohamed Mostafa Ibrahim",
//     style: TextStyle(
//         fontSize: 25.5, color: Color.fromARGB(255, 1, 14, 15)),
//   ),
//   const SizedBox(height: 30),
//   getCont(Icons.email, "Mohamedmostaf@gmail.com",
//       S.of(context).email),
//   const SizedBox(height: 10),
//   getCont(Icons.phone, "01032901480", S.of(context).Phone),
//   const SizedBox(height: 10),
//   getCont(
//     Icons.date_range,
//     "3/18/2024",
//     S.of(context).UserbirthDate,
//   ),
//   const SizedBox(height: 10),
//   getCont(Icons.credit_card, "30107120202336",
//       S.of(context).NationalId),
// ],
//               ),
//             ),
//           ),
//         ),
//       ),
//     );
//   }

Column getCont(IconData icon, dynamic st, String text) {
  return Column(
    mainAxisAlignment: MainAxisAlignment.start,
    children: [
      Row(children: [
        Text(
          text.toString() + ":",
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
              ),
            ],
          ),
        ),
      ),
    ],
  );
}
