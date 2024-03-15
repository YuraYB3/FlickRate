// ignore_for_file: avoid_print

import 'package:permission_handler/permission_handler.dart';

enum PermissionState { granted, denied, restricted }

class PermissionHandler {
  final Permission _permissionStorage = Permission.storage;
  final Permission _permissionNotification = Permission.notification;

  Future<PermissionState> isGalleryPermissionGranted() async {
    final status = await _permissionStorage.status;
    if (status.isGranted) {
      return PermissionState.granted;
    } else {
      final result = await _permissionStorage.request();
      switch (result) {
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
    final status = await _permissionNotification.status;
    if (status.isGranted) {
      return PermissionState.granted;
    } else {
      final result = await _permissionStorage.request();
      switch (result) {
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
  }
}
