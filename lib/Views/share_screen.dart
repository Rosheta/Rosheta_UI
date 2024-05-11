import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';

class SharingScreen extends StatelessWidget {


  static const String routeName = '/share-screen';

  @override
  Widget build(BuildContext context) {

    final message = ModalRoute.of(context)!.settings.arguments as RemoteMessage;

    print('Handling a background message $message');
    print('Message data: ${message.data}');
    print('Message notification: ${message.notification?.body}');
    print('Message notification title: ${message.notification?.title}');


    return Scaffold(
      appBar: AppBar(
        title: Text('Notification Screen'),
      ),
      body: Center(
        child: Column(
          children: [
            Text('$message'),
            Text('${message.data}'),
            Text('${message.notification?.body}'),
            Text('${message.notification?.title}'),
          ],),
      ),
    );
  }
}