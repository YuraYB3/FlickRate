// ignore_for_file: avoid_print

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
  }

  @override
  Future<void> localNotificationsInit() async {
    const AndroidInitializationSettings initializationSettingsAndroid =
        AndroidInitializationSettings('@drawable/ic_launcher');
    const InitializationSettings initializationSettings =
        InitializationSettings(android: initializationSettingsAndroid);
    await _flutterLocalNotificationsPlugin.initialize(initializationSettings);
  }

  @override
  Future<void> showSimpleNotification({
    required String title,
    required String body,
    required String payload,
  }) async {
    final androidNotificationDetails = AndroidNotificationDetails(
      _androidChannel.id,
      _androidChannel.name,
      channelDescription: _androidChannel.description,
      importance: Importance.max,
      priority: Priority.high,
    );
    final notificationDetails =
        NotificationDetails(android: androidNotificationDetails);
    await _flutterLocalNotificationsPlugin
        .show(0, title, body, notificationDetails, payload: payload);
  }
}
