// ignore_for_file: empty_catches

import 'dart:async';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

import '../main.dart';
import 'app.dart';

class LocalNotificationService {
  LocalNotificationService();
  static final FlutterLocalNotificationsPlugin _notificationsPlugin =
      FlutterLocalNotificationsPlugin();
  Future<void> initialize(InitializationSettings info) async {
    await _notificationsPlugin.initialize(info);
  }
  static Future<NotificationDetails> notificationDetails() async {
    const AndroidNotificationDetails androidNotificationDetails =
        AndroidNotificationDetails("com.yogesh.newsapp", "TradeLinkIndia",
            channelDescription: "description",
            importance: Importance.max,
            icon: "@mipmap/ic_launcher",
            priority: Priority.max,
          playSound: true,
          enableVibration: true,
          visibility: NotificationVisibility.public
        );
    DarwinNotificationDetails ios =  const DarwinNotificationDetails(
        sound: "default",
        presentSound: true,
        presentAlert: true,
        presentBadge: true);

    return NotificationDetails(android: androidNotificationDetails,iOS: ios );
  }

  Future<void> showNotification(
      {required int id, required String title, required String body}) async {
    final details = await notificationDetails();
    await _notificationsPlugin.show(id, title, body, details);
  }

  static void createAndDisplayNotification(RemoteMessage message) async {
    try {
      await _notificationsPlugin.show(
          1,
          message.notification!.title.toString(),
          message.notification!.body.toString(),
          await notificationDetails());
    } on Exception {
    }
  }
}

void settingsForNotification()async{
  const AndroidInitializationSettings initializationSettingsAndroid =
  AndroidInitializationSettings('@mipmap/ic_launcher');
  DarwinInitializationSettings initializationSettingsDarwin =
  DarwinInitializationSettings(
    requestSoundPermission: true,
    requestAlertPermission: true,
    defaultPresentSound: true,
    defaultPresentAlert: true,
    onDidReceiveLocalNotification: (id, title, body, payload) {
    },
  );

  InitializationSettings initializationSettings = InitializationSettings(
      android: initializationSettingsAndroid,
      iOS: initializationSettingsDarwin);

  await localNotificationService.initialize(initializationSettings);
  await FirebaseMessaging.instance.setForegroundNotificationPresentationOptions(
    alert: true,
    badge: true,
    sound: true,
  );
  AppHelper.myPrint( await FirebaseMessaging.instance.getToken());
  FirebaseMessaging.instance.getInitialMessage().then(
  (message) {
  if(message != null){
    AppHelper.myPrint("Data ${message.data}");
  // if (message.notification != null) {
  //   if (message.data['type'].toString() == "privatemessage") {
  //     var map = {};
  //     map['id'] = message.data['id'];
  //     map['name'] = message.data['name'];
  //     map['image'] = message.data['image'];
  //     navigatorKey.currentState
  //         ?.pushNamed("/privateChat", arguments: map);
  //   }else if(message.data['type'].toString() == "groupmessage"){
  //     var map = {};
  //     map['groupChatId'] = message.data['id'];
  //     map['groupName'] = message.data['name'];
  //     map['groupImage'] = message.data['image'];
  //
  //     navigatorKey.currentState
  //         ?.pushNamed("/chat", arguments: map);
  //   }
  // }
  }
  },
  );
  FirebaseMessaging.onMessage.listen(
  (message) {
  if (message.notification != null) {
  LocalNotificationService.createAndDisplayNotification(message);
  }
  },
  );

  FirebaseMessaging.onMessageOpenedApp.listen(
  (message) {
  if (message.notification != null) {
    AppHelper.myPrint("Data ${message.data}");

  // if(message.data['type'].toString() == "privatemessage"){
  //   var map = {};
  //   map['id'] = message.data['id'];
  //   map['name'] = message.data['name'];
  //   map['image'] = message.data['image'];
  //   navigatorKey.currentState?.pushNamed("/privateChat",arguments: map);
  // }else if(message.data['type'].toString() == "groupmessage"){
  //   var map = {};
  //   map['groupChatId'] = message.data['id'];
  //   map['groupName'] = message.data['name'];
  //   map['groupImage'] = message.data['image'];
  //   navigatorKey.currentState
  //       ?.pushNamed("/chat", arguments: map);
  // }
  }
  },
  );
}