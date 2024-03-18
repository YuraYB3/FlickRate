// ignore_for_file: avoid_print

import '../../../domain/notification/inotification_service.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

class NotificationService implements INotificationService {
  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;

  @override
  Future<void> initialize() async {
    print('we here');
    _requestNotificationPermissions();
    final fcmToken = await _firebaseMessaging.getToken();
    print('Token: $fcmToken');
    FirebaseMessaging.onBackgroundMessage(firebaseMessagingBackgroundHandler);
  }

  Future<void> _requestNotificationPermissions() async {
    await _firebaseMessaging.requestPermission();
  }
}

Future<void> firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  print('Title ${message.notification?.title}');
  print('Body ${message.notification?.body}');
  print('Payload ${message.data}');
}
