

import 'package:firebase_messaging/firebase_messaging.dart';
abstract interface class ILocalNotificationService {
  Future<void> showNotification({required RemoteMessage message});
   Future<void> showNotificationWithProgress(
      {required double progress, required int id});
}
