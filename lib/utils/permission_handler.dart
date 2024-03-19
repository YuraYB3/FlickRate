// ignore_for_file: avoid_print

import 'dart:io';

import 'package:permission_handler/permission_handler.dart';
import 'package:device_info/device_info.dart';

enum PermissionState { granted, denied, restricted }

class PermissionHandler {
  Future<PermissionState> isGalleryPermissionGranted() async {
    final Permission permissionStorage = await _isAndroidVersionAbove13()
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
  }

  Future<bool> _isAndroidVersionAbove13() async {
    if (Platform.isAndroid) {
      var androidInfo = await DeviceInfoPlugin().androidInfo;
      var release = androidInfo.version.release;
      var sdkInt = androidInfo.version.sdkInt;
      var manufacturer = androidInfo.manufacturer;
      var model = androidInfo.model;
      print('Android $release (SDK $sdkInt), $manufacturer $model');
      if (int.parse(release) >= 13) {
        return true;
      } else {
        return false;
      }
    }
    return false;
  }
}
