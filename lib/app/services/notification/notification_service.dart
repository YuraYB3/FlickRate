// ignore_for_file: avoid_print
import 'package:flickrate/domain/local_notification/ilocal_notification_service.dart';

import '../../../domain/notification/inotification_service.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

class NotificationService implements INotificationService {
  final ILocalNotificationService _localNotificationService;

  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;

  NotificationService(
      {required ILocalNotificationService localNotificationService})
      : _localNotificationService = localNotificationService {
    _init();
  }

  Future<void> _init() async {
    final fcmToken = await _firebaseMessaging.getToken();
    print('Token: $fcmToken');
    await _setNotificationsHandlers();
  }

  Future<void> _setNotificationsHandlers() async {
    //terminated

    FirebaseMessaging.instance.getInitialMessage().then((value) {});

    ///foreground
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      _localNotificationService.showNotification(message: message);
    });
    //background
    FirebaseMessaging.onMessageOpenedApp.listen(
      (RemoteMessage message) {
        if (message.notification != null) {
          print("Background Notification Tapped");
        }
      },
    );
  }
}
