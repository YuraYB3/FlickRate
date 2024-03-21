// ignore_for_file: avoid_print

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flickrate/app/common/device_info.dart';
import 'package:permission_handler/permission_handler.dart';

enum PermissionState { granted, denied, restricted }

class PermissionHandler {
  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;
  final DeviceInfo deviceInfo = DeviceInfo();
  Future<PermissionState> isGalleryPermissionGranted() async {
    final Permission permissionStorage =
        await deviceInfo.isAndroidVersionAbove12()
            ? Permission.photos
            : Permission.storage;
    if (await permissionStorage.status.isGranted) {
      return PermissionState.granted;
    } else {
      switch (await permissionStorage.request()) {
        case PermissionStatus.granted:
          return PermissionState.granted;
        case PermissionStatus.denied:
          return PermissionState.denied;
        case PermissionStatus.restricted:
          return PermissionState.restricted;
        default:
          return PermissionState.denied;
      }
    }
  }

  Future<PermissionState> isNotificationPermissionGranted() async {
    const Permission permissionNotification = Permission.notification;
    final status = await permissionNotification.status;
    if (status.isGranted) {
      return PermissionState.granted;
    } else {
      switch (await permissionNotification.request()) {
        case PermissionStatus.granted:
          return PermissionState.granted;
        case PermissionStatus.denied:
          return PermissionState.denied;
        case PermissionStatus.restricted:
          return PermissionState.restricted;
        default:
          return PermissionState.denied;
      }
    }
  }

  Future<void> askCorePermissions() async {
    await isNotificationPermissionGranted();
    await _requestNotificationPermissions();
  }

  Future<void> _requestNotificationPermissions() async {
    await _firebaseMessaging.requestPermission(
      alert: true,
      announcement: true,
      badge: true,
      carPlay: false,
      criticalAlert: false,
      provisional: false,
      sound: true,
    );
  }
}
