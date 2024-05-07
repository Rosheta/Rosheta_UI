import 'dart:convert';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:rosheta_ui/main.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future<void> handleBackgroundMessage(RemoteMessage message) async {
  if (message == null) return;
  
  navigatorKey.currentState?.pushNamed(
    "/share-screen",
    arguments: message,
  );
}

class FirebaseApi {
  final _androidChannel = const AndroidNotificationChannel(
    'share_channel',
    'Sharing Channel',
    description:
        'This channel is used for handle sharing data between patient and doctor',
    importance: Importance.defaultImportance,
  );

  final _flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

  void handleMessage(RemoteMessage? message) {
    if (message == null) return;

    navigatorKey.currentState?.pushNamed(
      "/share-screen",
      arguments: message,
    );
  }

  Future initLocalNotifications() async {
    const iOS = DarwinInitializationSettings();
    const android = AndroidInitializationSettings('@drawable/ic_launcher');
    const settings = InitializationSettings(android: android, iOS: iOS);

    await _flutterLocalNotificationsPlugin.initialize(
      settings,
      onDidReceiveNotificationResponse: (notificationResponse) async {
        if (notificationResponse != null) {
          final message =
              RemoteMessage.fromMap(jsonDecode(notificationResponse.payload!));
          handleMessage(message);
        }
      },
    );

    final platform =
        _flutterLocalNotificationsPlugin.resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin>();
    await platform?.createNotificationChannel(_androidChannel);
  }

  Future initPushNotifications() async {
    await FirebaseMessaging.instance
        .setForegroundNotificationPresentationOptions(
      alert: true,
      badge: true,
      sound: true,
    );

    // responsible for perfoorming an action when the app is open from a terminated state via a notification
    FirebaseMessaging.instance.getInitialMessage().then(handleMessage);
    // Same as above but when the app is in the background
    FirebaseMessaging.onMessageOpenedApp.listen(handleMessage);
    FirebaseMessaging.onBackgroundMessage(handleBackgroundMessage);
    FirebaseMessaging.onMessage.listen((message) {
      final notification = message.notification;
      if (notification == null) return;
      showDialog(
        context: navigatorKey.currentContext!,
        builder: (context) {
          return SimpleDialog(
            contentPadding: EdgeInsets.all(16),
            children: [
              Text("You have a new message to share data of patient"),
              ElevatedButton(
                onPressed: () {
                  Navigator.of(context).pop(); // Close the dialog
                  // Navigate to the share screen
                  navigatorKey.currentState?.pushNamed(
                    "/share-screen",
                    arguments: message,
                  );
                },
                child: Text('View Details'), // Button text
              ),
            ],
          );
        },
      );
    });
  }

  Future<void> initNotifications() async {
    final FirebaseMessaging firebaseMessaging =
        await FirebaseMessaging.instance;
    NotificationSettings settings = await firebaseMessaging.requestPermission(
      alert: true,
      badge: true,
      provisional: false,
      sound: true,
      announcement: false,
      carPlay: false,
      criticalAlert: false,
    );

    final token = await firebaseMessaging.getToken();
    // store token in your server and refrences it to send notifications
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('devicetoken', token!);

    await initPushNotifications();
    await initLocalNotifications();
  }
}
