// ignore_for_file: avoid_print

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

import '../../../domain/local_notification/ilocal_notification_service.dart';

class LocalNotificationService implements ILocalNotificationService {
  static const String channelId = 'easyaproach';
  static const String channelName = 'easyapproach channel';
  static const String channelDescription = 'Channel';
  static final FlutterLocalNotificationsPlugin
      _flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

  LocalNotificationService() {
    _init();
  }

  Future<void> _init() async {
    const InitializationSettings initializationSettings =
        InitializationSettings(
      android: AndroidInitializationSettings("@drawable/ic_launcher"),
    );
    await _flutterLocalNotificationsPlugin.initialize(initializationSettings);
  }

  @override
  Future<void> showNotification({required RemoteMessage message}) async {
    try {
      final id = DateTime.now().microsecond ~/ 1000;
      const NotificationDetails notificationDetails = NotificationDetails(
        android: AndroidNotificationDetails(
          channelId,
          channelName,
          channelDescription: channelDescription,
          importance: Importance.max,
          priority: Priority.high,
        ),
      );

      await _flutterLocalNotificationsPlugin.show(
          id,
          message.notification?.title ?? "",
          message.notification?.body ?? "",
          notificationDetails);
    } on Exception catch (e) {
      print(e);
    }
  }
}
