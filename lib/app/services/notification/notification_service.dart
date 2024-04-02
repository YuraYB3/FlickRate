// ignore_for_file: avoid_print
import 'package:firebase_core/firebase_core.dart';
import 'package:flickrate/app/routing/routes.dart';
import 'package:flickrate/domain/local_notification/ilocal_notification_service.dart';

import '../../../domain/notification/inotification_service.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

import '../../routing/inavigation_util.dart';

class NotificationService implements INotificationService {
  final ILocalNotificationService _localNotificationService;
  final INavigationUtil _navigationUtil;

  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;

  NotificationService(
      {required ILocalNotificationService localNotificationService,
      required INavigationUtil navigationUtil})
      : _localNotificationService = localNotificationService,
        _navigationUtil = navigationUtil {
    _init();
  }

  Future<void> _init() async {
    final fcmToken = await _firebaseMessaging.getToken();
    print('Token: $fcmToken');
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
          print("Background Notification Tapped");
          _onNotificationTapped();
        }
      },
    );
  }

  Future<void> _onNotificationTapped() async {
    await _navigationUtil.navigateTo(routeDefaultNotificationPage);
  }
}

@pragma("vm:entry-point")
Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp();
}
