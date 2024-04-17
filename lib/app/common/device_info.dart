// ignore_for_file: avoid_print

import 'dart:io';

import 'package:device_info/device_info.dart';

class DeviceInfo {
  Future<bool> isAndroidVersionAbove13() async {
    if (Platform.isAndroid) {
      AndroidDeviceInfo androidInfo = await DeviceInfoPlugin().androidInfo;
      String release = androidInfo.version.release;
      int sdkInt = androidInfo.version.sdkInt;
      String manufacturer = androidInfo.manufacturer;
      String model = androidInfo.model;
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
