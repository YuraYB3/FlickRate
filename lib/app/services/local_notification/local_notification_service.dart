// ignore_for_file: avoid_print

import 'dart:math';

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
    await _flutterLocalNotificationsPlugin.initialize(initializationSettings,
        onDidReceiveNotificationResponse: onNotificationTap,
        onDidReceiveBackgroundNotificationResponse: onNotificationTap);
  }

  @override
  Future<void> showNotification({required RemoteMessage message}) async {
    try {
      Random random = Random();
      final id = random.nextInt(1000);
      const NotificationDetails notificationDetails = NotificationDetails(
        android: AndroidNotificationDetails(
          channelId,
          channelName,
          channelDescription: channelDescription,
          importance: Importance.max,
          priority: Priority.high,
        ),
      );

      if (message.notification != null) {
        await _flutterLocalNotificationsPlugin.show(
            id,
            message.notification!.title ?? "",
            message.notification!.body ?? "",
            notificationDetails);
      }
    } on Exception catch (e) {
      print(e);
    }
  }

  static void onNotificationTap(
      NotificationResponse notificationResponse) async {
    //   INavigationUtil navigationUtil = locator<INavigationUtil>();
    //   navigationUtil.navigateTo(routeDefaultNotificationPage);
    print('clicked');
  }
}
