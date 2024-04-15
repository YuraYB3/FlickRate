

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:firebase_storage/firebase_storage.dart';

abstract interface class ILocalNotificationService {
  Future<void> showNotification({required RemoteMessage message});
   Future<void> showNotificationWithProgress(
      {required RemoteMessage message, required UploadTask task});
}
