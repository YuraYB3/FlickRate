// ignore_for_file: avoid_print

import 'dart:async';
import 'dart:math';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

import '../../../domain/local_notification/ilocal_notification_service.dart';

class LocalNotificationService implements ILocalNotificationService {
  static const String channelId = 'easyaproach';
  static const String channelName = 'easyaproach channel';
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
      iOS: DarwinInitializationSettings(
        requestAlertPermission: true,
        requestBadgePermission: true,
        requestSoundPermission: true
      )
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

  @override
  Future<void> showNotificationWithProgress(
      {required double progress, required int id}) async {
    try {
      String channel = 'progress';
      print('notification id:$id');
      NotificationDetails notificationDetails = NotificationDetails(
        android: AndroidNotificationDetails(channel, channel,
            channelDescription: channel,
            importance: Importance.low,
            priority: Priority.low,
            showProgress: true,
            progress: progress.round(),
            ongoing: progress.round() != 100,
            maxProgress: 100),
      );
      if (progress.round() == 100) {
        _flutterLocalNotificationsPlugin.cancel(id);
      } else {
        _flutterLocalNotificationsPlugin.show(
            id, 'Uploading', 'Uploading progress', notificationDetails);
      }
      print("progress $progress");
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
