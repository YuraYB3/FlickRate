// ignore_for_file: avoid_print

import 'dart:convert';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flickrate/domain/notification/inotification_service.dart';
import 'package:flickrate/locator.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'app/app.dart';
import 'app/routing/app_router.dart';
import 'app/routing/inavigation_util.dart';
import 'app/routing/navigation_util.dart';
import 'app/services/user/iuser_service.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  _initServices();
  final INavigationUtil navigationUtil = NavigationUtil();
  final INotificationService notificationService =
      locator<INotificationService>();
  await _initNotifications(notificationService);
  runApp(MultiProvider(
    providers: [
      Provider.value(value: navigationUtil),
    ],
    child: App(
      userService: locator<IUserService>(),
      appRouter: AppRouter(),
    ),
  ));
}

Future<void> _initNotifications(
    INotificationService notificationService) async {
  await notificationService.init();
  await notificationService.localNotificationsInit();

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
      notificationService.showSimpleNotification(
          title: message.notification!.title!,
          body: message.notification!.body!,
          payload: payloadData);
    }
  });
  final RemoteMessage? message =
      await FirebaseMessaging.instance.getInitialMessage();
  if (message != null) {
    print("Launched from terminated state");
    await Future.delayed(const Duration(seconds: 1), () {});
  }
}

void _initServices() {
  initFunctionService();
  initPermissionHandler();
  initNetworkService();
  initStorageService();
  initNotificationService();
  initRepos();
  initAuthService();
  initUserService();
}

Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  print('Title ${message.notification?.title}');
  print('Body ${message.notification?.body}');
  print('Payload ${message.data}');
}
