// ignore_for_file: library_private_types_in_public_api

import 'package:flutter/material.dart';
import 'package:rosheta_ui/models/msg_model.dart';
import 'package:rosheta_ui/models/msgs_model.dart';
import 'package:rosheta_ui/services/chat_service.dart';

class ChatScreen extends StatefulWidget {
  final String name;
  final String chatId;
  final String? imageUrl;

  const ChatScreen(
      {super.key, required this.name, required this.chatId, this.imageUrl});

  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  late Future<List<Message>> messages;
  late String userId;
  TextEditingController messageController = TextEditingController();

  Future<List<Message>> _fetchMessages() async {
    try {
      ChatApi chat = ChatApi();
      Messages messages = await chat.getmsgs(widget.chatId);
      userId = messages.userId!;
      List<Message> listOfMsgs =
          messages.msgs!.map((e) => Message.fromJson(e)).toList();
      return listOfMsgs;
    } catch (e) {
      throw Exception('Failed to fetch profile');
    }
  }

  @override
  Widget build(BuildContext context) {
    messages = _fetchMessages();
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.cyan,
          titleSpacing: 0.0,
          title: Row(children: [
            CircleAvatar(
              radius: 20.0,
              backgroundImage: widget.imageUrl != null
                  ? Image.network(widget.imageUrl ?? '').image
                  : Image.asset('Images/profile.png').image
                      as ImageProvider<Object>?,
            ),
            const SizedBox(width: 10.0),
            Flexible(
              child: Text(
                widget.name,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                  color: Colors.white,
                ),
              ),
            ),
          ]),
        ),
        body: FutureBuilder<List<Message>>(
            future: messages,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                // return dumy(context);
                return const Center(
                  child: CircularProgressIndicator(),
                );
              } else if (snapshot.hasError) {
                // return dumy(context);
                return Center(
                  child: Text('Error: ${snapshot.error}'),
                );
              } else {
                List<Message> msgs = snapshot.data!;
                return Container(
                  color: const Color.fromARGB(255, 233, 255, 255),
                  child:
                    Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: Column(
                          children: [
                            // show messages here
                            Expanded(
                              child: ListView.separated(
                                physics: const BouncingScrollPhysics(),
                                itemBuilder: (context, index) {
                                  if (userId == msgs[index].sender) {
                                    return buildMyMessage(
                                        context , msgs[index].message!, msgs[index].time!);
                                  }
                                  return buildMessage(
                                      context ,msgs[index].message!, msgs[index].time!);
                                },
                                separatorBuilder: (context, index) => const SizedBox(
                                  height: 15.0,
                                ),
                                itemCount: msgs.length,
                              ),
                            ),
                            Container(
                              decoration: BoxDecoration(
                                border: Border.all(
                                  color: Colors.grey,
                                  width: 1.0,
                                ),
                                borderRadius: BorderRadius.circular(
                                  15.0,
                                ),
                              ),
                              clipBehavior: Clip.antiAliasWithSaveLayer,
                              child: Row(
                                children: [
                                  Expanded(
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(
                                        horizontal: 15.0,
                                      ),
                                      child: TextFormField(
                                        controller: messageController,
                                        decoration: const InputDecoration(
                                          border: InputBorder.none,
                                          hintText: 'type your message here ...',
                                        ),
                                      ),
                                    ),
                                  ),
                                  Container(
                                    height: 50.0,
                                    color: Colors.cyan,
                                    child: MaterialButton(
                                      onPressed: () {
                                        // send message
                                      },
                                      minWidth: 1.0,
                                      child: const Icon(
                                        Icons.send,
                                        size: 16.0,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                    ),
                  )
                );
              }
            }));
  }
}

Widget buildMessage(BuildContext context , String msg, String time) => Align(
      alignment: AlignmentDirectional.centerStart,
      child: Container(
        decoration: BoxDecoration(
            color: Colors.indigo[900],
            borderRadius: const BorderRadiusDirectional.only(
              bottomEnd: Radius.circular(
                10.0,
              ),
              topStart: Radius.circular(
                10.0,
              ),
              topEnd: Radius.circular(
                10.0,
              ),
            ),
          ),
          padding: const EdgeInsets.symmetric(
            vertical: 5.0,
            horizontal: 10.0,
          ),
        child: SizedBox(
            width: MediaQuery.of(context).size.width / 2, // Set the width to half of the screen width
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  alignment: Alignment.topLeft,
                  child: Text(
                    msg,
                    style: const TextStyle(
                      color: Colors.white,
                    ),
                  ),
                ),
                Container(
                  alignment: Alignment.bottomRight,
                  child: Text(
                    time,
                    style: const TextStyle(
                      color: Colors.grey,
                    ),
                  ),
                )
              ],
            ),
          ),
      ),
    );

Widget buildMyMessage(BuildContext context ,String msg, String time) => Align(
      alignment: AlignmentDirectional.centerEnd,
      child: Container(
        decoration: BoxDecoration(
            color: Colors.indigo[500],
            borderRadius: const BorderRadiusDirectional.only(
              bottomStart: Radius.circular(
                10.0,
              ),
              topStart: Radius.circular(
                10.0,
              ),
              topEnd: Radius.circular(
                10.0,
              ),
            ),
          ),
          padding: const  EdgeInsets.symmetric(
            vertical: 5.0,
            horizontal: 10.0,
          ),
        child:  SizedBox(
            width: MediaQuery.of(context).size.width / 2, // Set the width to half of the screen width
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  alignment: Alignment.topLeft,
                  child: Text(
                    msg,
                    style: const TextStyle(
                      color: Colors.white,
                    ),
                  ),
                ),
                Container(
                  alignment: Alignment.bottomRight,
                  child: Text(
                    time,
                    style: const TextStyle(
                      color: Colors.grey,
                    ),
                  ),
                )
              ],
            ),
          ),
      ),
    );
