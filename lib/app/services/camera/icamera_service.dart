import 'package:flickrate/app/services/camera/icamera_config.dart';
import 'package:flickrate/app/services/camera/icamera_core.dart';
import 'package:flutter/material.dart';

enum CameraState{
  init, ready, recording, recorded, paused, dispose, error
}
abstract class ICameraService {

  final ICameraCore cameraCore;
  final ICameraConfig cameraConfig;

  CameraState get cameraState;

  Widget get cameraPreview;

  Size get previewSize;

  ICameraService ({
    required this.cameraConfig,
    required this.cameraCore
  });

  Future<void> create();

  Future<void> reset();

  void dispose();

  Future<void> toggleCamera();

  Future<String?> takePicture();

}
