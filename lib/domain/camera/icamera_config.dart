// ignore_for_file: file_names

import 'package:camera/camera.dart';

const cameraResolutionPreset = ResolutionPreset.veryHigh;

abstract class ICameraConfig {
  final ResolutionPreset cameraResolutionPreset;

  ICameraConfig({required this.cameraResolutionPreset});
}
