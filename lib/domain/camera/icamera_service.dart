import 'package:camera/camera.dart';
import 'package:flickrate/domain/camera/icamera_config.dart';
import 'package:flickrate/domain/camera/icamera_core.dart';
import 'package:flutter/material.dart';

enum CameraState{init, ready, error}
abstract class ICameraService {

  final ICameraCore cameraCore;
  final ICameraConfig cameraConfig;

 CameraState get cameraState;

 void initCamera();


  Widget get cameraPreview;

  Size get previewSize;

  CameraController get cameraController;

  ICameraService ({
    required this.cameraConfig,
    required this.cameraCore
  });

  Future<void> reset();

  void dispose();

  Future<void> toggleCamera();

  Stream<CameraState> get cameraStateStream;

 Future<XFile?> takePicture();

}
