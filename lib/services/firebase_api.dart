import 'dart:convert';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:rosheta_ui/Views/share_screen.dart';
import 'package:rosheta_ui/main.dart';

Future<void> handleBackgroundMessage(RemoteMessage message) async {
  print(message);
  // if (message == null) return;

  navigatorKey.currentState?.pushNamed(
    SharingScreen.routeName,
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
      SharingScreen.routeName,
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
      _flutterLocalNotificationsPlugin.show(
        notification.hashCode,
        notification.title,
        notification.body,
        NotificationDetails(
          android: AndroidNotificationDetails(
              _androidChannel.id, _androidChannel.name,
              channelDescription: _androidChannel.description,
              icon: '@mipmap/ic_launcher'),
        ),
        payload: jsonEncode(message.toMap()),
      );
    });
  }

  Future<void> initNotifications() async {
    final FirebaseMessaging _firebaseMessaging =
        await FirebaseMessaging.instance;
    await _firebaseMessaging.requestPermission(
      alert: true,
      badge: true,
      provisional: false,
      sound: true,
    );
    final token = await _firebaseMessaging.getToken();
    // store token in your server and refrences it to send notifications
    print('Token: $token');

    await initPushNotifications();
    await initLocalNotifications();
  }
}
