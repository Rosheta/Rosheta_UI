import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:rosheta_ui/Views/chat/chat_screen.dart';
import 'package:rosheta_ui/drawer/drawers.dart';
import 'package:rosheta_ui/generated/l10n.dart';
import 'package:rosheta_ui/models/chat/friend_model.dart';
import 'package:rosheta_ui/services/chat/chat_service.dart';

class FriendsScreen extends StatefulWidget {
  const FriendsScreen({super.key});

  @override
  _FriendsScreenState createState() => _FriendsScreenState();
}

class _FriendsScreenState extends State<FriendsScreen> {
  late Future<List<Friend>> friends;
  Future<List<Friend>> _fetchfriends() async {
    try {
      ChatApi chat = ChatApi();
      return await chat.getfriends();
    } catch (e) {
      throw Exception('Failed to fetch profile');
    }
  }

  @override
  Widget build(BuildContext context) {
    friends = _fetchfriends();
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.cyan,
        title: Text(
          S.of(context).chat,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 25,
            color: Colors.white,
          ),
        ),
        centerTitle: true,
      ),
      drawer: select_drawer(context),
      backgroundColor: const Color.fromARGB(255, 233, 255, 255),
      body: FutureBuilder<List<Friend>>(
        future: friends,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            // return dumy(context);
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (snapshot.hasError) {
            return Center(
              child: Text('Error: ${snapshot.error}'),
            );
          } else {
            List<Friend> pr = snapshot.data!;
            return Padding(
              padding: const EdgeInsets.all(20.0),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ListView.separated(
                      physics: const NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemBuilder: (context, index) => buildChatItem(
                        imageURL: pr[index].avatarUrl,
                        chatId: pr[index].chatId!,
                        name: pr[index].name!,
                        msg: pr[index].message!,
                        time: pr[index].time!,
                        context: context,
                      ),
                      separatorBuilder: (context, index) => const SizedBox(
                        height: 20.0,
                      ),
                      itemCount: pr.length,
                    ),
                  ],
                ),
              ),
            );
          }
        },
      ),
    
    );
  }

  Widget buildChatItem(
          {String? imageURL,
          required String chatId,
          required String name,
          required String msg,
          required String time,
          required BuildContext context}) =>
      InkWell(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => ChatScreen(
                      name: name,
                      chatId: chatId,
                      imageUrl: imageURL,
                    )),
          );
        },
        child: Row(
          children: [
            Stack(
              alignment: AlignmentDirectional.bottomEnd,
              children: [
                CircleAvatar(
                  radius: 30.0,
                  backgroundImage: imageURL != null
                      ? Image.network(imageURL).image
                      : Image.asset('Images/profile.png').image
                          as ImageProvider<Object>?,
                )
              ],
            ),
            const SizedBox(
              width: 20.0,
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    name,
                    style: const TextStyle(
                      fontSize: 16.0,
                      fontWeight: FontWeight.bold,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(
                    height: 5.0,
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          msg,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      Text(
                        convertToTimeString(time),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            // ),
          ],
        ),
      );

  String convertToTimeString(String dateTimeString) {
    DateTime dateTime = DateTime.parse(dateTimeString);
    String formattedTime = DateFormat.jm().format(dateTime);
    return formattedTime;
  }
}
