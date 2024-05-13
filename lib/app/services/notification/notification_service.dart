import 'dart:developer';
import 'dart:io';

import 'package:firebase_core/firebase_core.dart';
import 'package:flickrate/domain/local_notification/ilocal_notification_service.dart';

import '../../../domain/notification/inotification_service.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

class NotificationService implements INotificationService {
  final ILocalNotificationService _localNotificationService;

  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;

  NotificationService({
    required ILocalNotificationService localNotificationService,
  }) : _localNotificationService = localNotificationService {
    _init();
  }

  Future<void> _init() async {
    String? token;
    if (Platform.isIOS) {
      token = await _firebaseMessaging.getAPNSToken();
    } else {
      token = await _firebaseMessaging.getToken();
    }
    log("THIS IS TOKEN: $token");
    await _setNotificationsHandlers();
  }

  Future<void> _setNotificationsHandlers() async {
    //terminated
    FirebaseMessaging.instance
        .getInitialMessage()
        .then((RemoteMessage? message) {
      if (message?.notification != null) {
        _onNotificationTapped();
      }
    });
    FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);

    ///foreground
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      _localNotificationService.showNotification(message: message);
    });
    //background
    FirebaseMessaging.onMessageOpenedApp.listen(
      (RemoteMessage message) {
        if (message.notification != null) {
          log("Background Notification Tapped");
          _onNotificationTapped();
        }
      },
    );
  }

  Future<void> _onNotificationTapped() async {
    // await _navigationUtil.navigateTo(routeDefaultNotificationPage);
  }
}

@pragma("vm:entry-point")
Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp();
}
