// ignore_for_file: avoid_print

import 'package:permission_handler/permission_handler.dart';

enum PermissionState { granted, notAllowed, restricted }

class PermissionHandler {
  final Permission _permissionStorage = Permission.storage;

  Future<PermissionState> isGalleryPermissionGranted() async {
    try {
      final status = await _permissionStorage.status;
      if (status.isGranted) {
        return PermissionState.granted;
      } else if (status.isDenied) {
        final result = await _permissionStorage.request();
        if (result.isGranted) {
          return PermissionState.granted;
        } else if (result.isDenied) {
          return PermissionState.notAllowed;
        } else if (result.isPermanentlyDenied) {
          return PermissionState.restricted;
        }
      }
      return PermissionState.restricted;
    } catch (e) {
      print('Error: $e');
      return PermissionState.restricted;
    }
  }
}
