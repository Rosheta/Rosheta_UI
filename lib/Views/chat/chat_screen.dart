// ignore_for_file: library_private_types_in_public_api

import 'dart:async';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:rosheta_ui/models/chat/msg_model.dart';
import 'package:rosheta_ui/models/chat/msgs_model.dart';
import 'package:rosheta_ui/services/chat/chat_service.dart';
import 'package:rosheta_ui/services/register/login_service.dart';
import 'package:rosheta_ui/services/chat/socket_service.dart';
import 'package:rosheta_ui/generated/l10n.dart';

class ChatScreen extends StatefulWidget {
  final String name;
  final String chatId;
  final String? userIdSecondPerson;
  final String? imageUrl;

  const ChatScreen(
      {super.key,
      this.userIdSecondPerson,
      required this.name,
      required this.chatId,
      this.imageUrl});

  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  late String userId;
  TextEditingController messageController = TextEditingController();
  SocketService socketService = SocketService();
  String token = LoginApi().getAccessToken().toString();
  late Future<List<Message>> messages;
  final _scrollController = ScrollController(keepScrollOffset: false);
  bool flag = true;
  bool flag2 = true;
  int page = 2;
  double tmpOffset = 0.0;

  Future<List<Message>> _fetchMessages() async {
    try {
      ChatApi chat = ChatApi();
      Messages message = await chat.getmsgs(widget.chatId, 1);
      userId = message.userId!;
      List<Message> listOfMsgs =
          message.msgs!.map((e) => Message.fromJson(e)).toList();
      return listOfMsgs;
    } catch (e) {
      throw Exception('Failed to fetch profile');
    }
  }

  @override
  void initState() {
    super.initState();
    messages = _fetchMessages();
    socketService.socket.on(widget.chatId, (data) {
      setState(() {
        // Append the new message to the existing list
        messages = messages.then((msgs) {
          msgs.add(Message.fromJson(data));
          return msgs;
        });
      });
    });

    _scrollController.addListener(() async {
      if ((_scrollController.position.pixels ==
          _scrollController.position.minScrollExtent) && flag2) {
        flag = false;
        ChatApi chat = ChatApi();
        Messages message = await chat.getmsgs(widget.chatId, page);
        userId = message.userId!;
        List<Message> listOfMsgs =
            message.msgs!.map((e) => Message.fromJson(e)).toList();
        List<Message> existingMessages = await messages;
        List<Message> updatedMessages = listOfMsgs + existingMessages;
        setState(() {
          page++;
          messages = Future.value(updatedMessages);
          if(listOfMsgs.isEmpty)
            flag2 = false;
        });
      }
    });
  }

  void _scrollToBottom() {
    _scrollController.jumpTo(_scrollController.position.maxScrollExtent);
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
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
                return const Center(
                  child: CircularProgressIndicator(),
                );
              } else if (snapshot.hasError) {
                return Center(
                  child: Text('Error: ${snapshot.error}'),
                );
              } else {
                List<Message> msgs = snapshot.data!;
                WidgetsBinding.instance.addPostFrameCallback((_) {
                  if (flag) {
                    tmpOffset = _scrollController.position.maxScrollExtent;
                    _scrollToBottom();
                  } else {
                    print('tmpOffset: $tmpOffset  max: ${_scrollController.position.maxScrollExtent}');
                    double tmm = (_scrollController.position.maxScrollExtent - tmpOffset - 20) < 0 ? 0 : (_scrollController.position.maxScrollExtent - tmpOffset - 20);
                    _scrollController.jumpTo(tmm);
                    tmpOffset = _scrollController.position.maxScrollExtent;
                  }
                });
                return Container(
                    color: const Color.fromARGB(255, 233, 255, 255),
                    child: Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Column(
                        children: [
                          // show messages here
                          Expanded(
                            child: ListView.separated(
                              controller: _scrollController,
                              itemBuilder: (context, index) {
                                if (userId != msgs[index].sender) {
                                  return buildMessage(
                                      context,
                                      msgs[index].message!,
                                      msgs[index].time!,
                                      Colors.indigo[300]!,
                                      AlignmentDirectional.centerEnd);
                                }
                                return buildMessage(
                                    context,
                                    msgs[index].message!,
                                    msgs[index].time!,
                                    Colors.indigo[900]!,
                                    AlignmentDirectional.centerStart);
                              },
                              separatorBuilder: (context, index) =>
                                  const SizedBox(height: 15.0),
                              itemCount: msgs.length,
                            ),
                          ),
                          const SizedBox(height: 20.0),
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
                                      decoration: InputDecoration(
                                        border: InputBorder.none,
                                        hintText: S.of(context).hinttextmsg,
                                      ),
                                    ),
                                  ),
                                ),
                                Container(
                                  height: 50.0,
                                  color: Colors.cyan,
                                  child: MaterialButton(
                                    onPressed: () {
                                      if (messageController.text.isEmpty) {
                                        return;
                                      }
                                      socketService.socket.emit('sendMessage', {
                                        'senderId': userId,
                                        'chatId': widget.chatId.toString(),
                                        'message': messageController.text
                                      });
                                      messageController.clear();
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
                    ));
              }
            }));
  }

  Widget buildMessage(BuildContext context, String msg, String time,
          Color color, AlignmentDirectional alignment) =>
      Align(
        // alignment: AlignmentDirectional.centerStart,
        alignment: alignment,
        child: Container(
          decoration: BoxDecoration(
            // color: Colors.indigo[900],
            color: color,
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
            width: MediaQuery.of(context).size.width /
                2, // Set the width to half of the screen width
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
                    convertToTimeString(time),
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

  String convertToTimeString(String dateTimeString) {
    DateTime dateTime = DateTime.parse(dateTimeString);
    String formattedTime = DateFormat.jm().format(dateTime);
    return formattedTime;
  }
}
