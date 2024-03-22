// ignore_for_file: avoid_print

import 'dart:convert';

import 'package:flutter_local_notifications/flutter_local_notifications.dart';

import '../../../domain/notification/inotification_service.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

class NotificationService implements INotificationService {
  static final FirebaseMessaging _firebaseMessaging =
      FirebaseMessaging.instance;
  static final FlutterLocalNotificationsPlugin
      _flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
  static const AndroidNotificationChannel _androidChannel =
      AndroidNotificationChannel(
    'high_importance_channel',
    'High',
    importance: Importance.max,
  );

  @override
  Future<void> init() async {
    final fcmToken = await _firebaseMessaging.getToken();
    print('Token: $fcmToken');
    await localNotificationsInit();
    await setNotificationsHandlers();
  }

  Future<void> setNotificationsHandlers() async {
    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      if (message.notification != null) {
        print("Background Notification Tapped");
      }
    });
    FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      String payloadData = jsonEncode(message.data);
      print("Got a message in foreground");
      if (message.notification != null) {
        showNotification(
          title: message.notification!.title!,
          body: message.notification!.body!,
          payload: payloadData,
        );
      }
    });
    final RemoteMessage? message =
        await FirebaseMessaging.instance.getInitialMessage();
    if (message != null) {
      print("Launched from terminated state");
    }
  }

  Future<void> localNotificationsInit() async {
    const AndroidInitializationSettings initializationSettingsAndroid =
        AndroidInitializationSettings('@drawable/ic_launcher');
    const InitializationSettings initializationSettings =
        InitializationSettings(android: initializationSettingsAndroid);
    await _flutterLocalNotificationsPlugin.initialize(initializationSettings);
  }

  Future<void> showNotification(
      {required String title,
      required String body,
      required String payload,
      int maxProgress = 100,
      int currentProgress = 0}) async {
    final androidNotificationDetails = AndroidNotificationDetails(
        _androidChannel.id, _androidChannel.name,
        channelDescription: _androidChannel.description,
        importance: Importance.high,
        priority: Priority.high,
        progress: currentProgress,
        maxProgress: maxProgress,
        showProgress: true);
    final notificationDetails =
        NotificationDetails(android: androidNotificationDetails);
    await _flutterLocalNotificationsPlugin
        .show(0, title, body, notificationDetails, payload: payload);
  }
}

Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  if (message.notification != null) {
    final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
        FlutterLocalNotificationsPlugin();
    String payloadData = jsonEncode(message.data);
    const AndroidNotificationChannel androidChannel =
        AndroidNotificationChannel('high_importance_channel', 'High',
            importance: Importance.max);
    final androidNotificationDetails = AndroidNotificationDetails(
        androidChannel.id, androidChannel.name,
        channelDescription: androidChannel.description,
        importance: Importance.high,
        priority: Priority.high,
        progress: 0,
        maxProgress: 10,
        showProgress: true);
    final notificationDetails =
        NotificationDetails(android: androidNotificationDetails);
    await flutterLocalNotificationsPlugin.show(0, message.notification!.title,
        message.notification!.body, notificationDetails,
        payload: payloadData);
  }
}
