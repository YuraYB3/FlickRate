// ignore_for_file: avoid_print

import 'dart:io';

import 'package:camera/camera.dart';
import 'package:flickrate/app/services/camera/icamera_config.dart';
import 'package:flickrate/app/services/camera/icamera_core.dart';
import 'package:flutter/material.dart';

import 'icamera_service.dart';

class CameraService extends ChangeNotifier
    with WidgetsBindingObserver
    implements ICameraService {

  @override
  final ICameraCore cameraCore;

  @override
  final ICameraConfig cameraConfig;

  @override
  CameraState get cameraState => _cameraState;
  CameraState _cameraState = CameraState.init;

  bool _isCameraControllerDisposed = false;
  bool _isObserverAdded = false;
  
  @override
  Widget get cameraPreview => _cameraPreview ?? const SizedBox();
  

  CameraController? _cameraController;
  CameraPreview? _cameraPreview;
  
  int _currentCameraId = 0;

  List<CameraDescription> get cameraList => cameraCore.cameraList;

   CameraService({
    required this.cameraCore,
    required this.cameraConfig
  });
  
  @override
  Size get previewSize => _cameraController?.value.previewSize ?? const Size(0, 0);
  
  @override
  void didChangeAppLifecycleState(AppLifecycleState state) async{
    if (_cameraController == null) return; 
    if (!_cameraController!.value.isInitialized) return;

    if (state == AppLifecycleState.inactive) {
      if (!_isCameraControllerDisposed) {
        _disposeCameraController();
      }
    }

    else if (state == AppLifecycleState.resumed){
      if (!_isCameraControllerDisposed) {
        await reset();
      }
      await create();
    }
  }

  @override
  void dispose(){
    reset();
    (WidgetsBinding.instance).removeObserver(this);
    _isObserverAdded = false;
    super.dispose();
  }
  @override
  Future<void> create() async {
    if (!_isObserverAdded) {
      WidgetsBinding.instance.addObserver(this);
      _isObserverAdded = true;
    }

    _cameraController = CameraController(cameraList[_currentCameraId], cameraConfig.cameraResolutionPreset, imageFormatGroup: ImageFormatGroup.yuv420);
    try {
      await _cameraController!.initialize();
      if (Platform.isIOS) {
        await _cameraController!.prepareForVideoRecording();
      }
      _cameraPreview = CameraPreview(_cameraController!);
      _updateCameraState(CameraState.ready);
    } on CameraException catch (e) {
      _updateCameraState(CameraState.error);
      print(e.toString());
    }
  }

  @override
  Future<void> reset() async {
    await _disposeCameraController();
    _cameraPreview = null;
    _currentCameraId = 0;
  }
  
  @override
  Future<String?> takePicture() async {
    try {
      _cameraController!.setFlashMode(FlashMode.off);
      XFile xFile =  await _cameraController!.takePicture();
      return xFile.path;
    } on CameraException catch (e) {
      _updateCameraState(CameraState.error);
      print(e.toString());
      return null;
    }

  }
  
  @override
  Future<void> toggleCamera() async {
    _currentCameraId = _currentCameraId == 0 ? 1 : 0;
    await _disposeCameraController();
    _cameraPreview = null;
    _updateCameraState(CameraState.init);
    return await create();
  }
  
  Future<void> _disposeCameraController() async {
    await _cameraController?.dispose();
    _cameraController = null;
    _isCameraControllerDisposed = true;
  }

  
  void _updateCameraState(CameraState state) {
      _cameraState = state;
  }

}
    
    
