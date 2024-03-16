// ignore_for_file: avoid_print

import 'dart:io';

import 'package:permission_handler/permission_handler.dart';
import 'package:device_info/device_info.dart';

enum PermissionState { granted, denied, restricted }

class PermissionHandler {
  late bool isAndroidAbove13;

  PermissionHandler() {
    _isAndroidVersionAbove13();
  }
  Future<PermissionState> isGalleryPermissionGranted() async {
    final Permission permissionStorage =
        isAndroidAbove13 ? Permission.photos : Permission.storage;
    final status = await permissionStorage.status;
    if (status.isGranted) {
      return PermissionState.granted;
    } else {
      final result = await permissionStorage.request();
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
    const Permission permissionNotification = Permission.notification;
    final status = await permissionNotification.status;
    if (status.isGranted) {
      await permissionNotification.request();
      return PermissionState.granted;
    } else {
      final result = await permissionNotification.request();
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

  Future<bool> _isAndroidVersionAbove13() async {
    if (Platform.isAndroid) {
      final AndroidDeviceInfo androidInfo =
          await DeviceInfoPlugin().androidInfo;
      isAndroidAbove13 = androidInfo.version.sdkInt >= 13;
    }
    return false;
  }
}
