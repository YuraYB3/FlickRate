// ignore_for_file: avoid_print

import 'dart:io';

import 'package:device_info/device_info.dart';

class DeviceInfo {
  Future<bool> isAndroidVersionAbove13() async {
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
