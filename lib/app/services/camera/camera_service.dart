import 'dart:async';
import 'dart:developer';
import 'dart:io';

import 'package:camera/camera.dart';
import 'package:flutter/material.dart';

import '../../../domain/camera/icamera_config.dart';
import '../../../domain/camera/icamera_core.dart';
import '../../../domain/camera/icamera_service.dart';

class CameraService extends ChangeNotifier
    with WidgetsBindingObserver
    implements ICameraService {
  @override
  final ICameraCore cameraCore;

  @override
  final ICameraConfig cameraConfig;

  CameraService({
    required this.cameraConfig,
    required this.cameraCore,
  });

  CameraController? _cameraController;

  @override
  CameraController get cameraController => _cameraController!;

  CameraPreview? _cameraPreview;

  @override
  Widget get cameraPreview => _cameraPreview ?? const SizedBox();

  CameraState _cameraState = CameraState.init;

  @override
  CameraState get cameraState => _cameraState;

  bool _isObserverAdded = false;
  int _currentCameraId = 0;

  List<CameraDescription> get cameraList => cameraCore.cameraList;

  late StreamController<CameraState> _cameraStateController;
  @override
  Stream<CameraState> get cameraStateStream => _cameraStateController.stream;

  @override
  Size get previewSize =>
      _cameraController?.value.previewSize ?? const Size(0, 0);

  bool _isCameraControllerDisposed = false;

  @override
  void initCamera() {
    log('init');
    WidgetsBinding.instance.addObserver(this);
    _cameraStateController = StreamController.broadcast();
    _create();
  }

  @override
  void dispose() {
    log('Camera dispose 1');
    reset();
    WidgetsBinding.instance.removeObserver(this);
    _cameraStateController.close();
    super.dispose();
  }

  @override
  Future<void> didChangeAppLifecycleState(AppLifecycleState state) async {
    log('did');
    if (_cameraController == null || !_cameraController!.value.isInitialized) {
      return;
    }
    if (state == AppLifecycleState.inactive) {
      if (!_isCameraControllerDisposed) {
        await _disposeCameraController();
      }
    } else if (state == AppLifecycleState.resumed) {
      if (!_isCameraControllerDisposed) {
        await reset();
      }
    }
    await _create();
  }

  Future<void> _create() async {
    log('create');

    if (!_isObserverAdded) {
      WidgetsBinding.instance.addObserver(this);
      _isObserverAdded = true;
    }
    _cameraController = CameraController(
      cameraList[_currentCameraId],
      cameraConfig.cameraResolutionPreset,
      imageFormatGroup: ImageFormatGroup.yuv420,
    );
    try {
      await _cameraController!.initialize();
      if (Platform.isIOS) {
        await _cameraController!.prepareForVideoRecording();
      }
      _cameraPreview = CameraPreview(_cameraController!);
      _updateCameraState(CameraState.ready);
    } on CameraException catch (e) {
      _updateCameraState(CameraState.error);
      log(e.toString());
    }
  }

  void _updateCameraState(CameraState state) {
    log('update');
    _cameraState = state;
    _cameraStateController.add(state);
  }

  @override
  Future<void> toggleCamera() async {
    log('tog');
    _updateCameraState(CameraState.init);
    _currentCameraId = _currentCameraId == 0 ? 1 : 0;
    await _disposeCameraController();
    _cameraPreview = null;
    _create();
  }

  @override
  Future<void> reset() async {
    log('reset');
    await _disposeCameraController();
    _cameraPreview = null;
    _currentCameraId = 0;
    _isCameraControllerDisposed = false;
  }

  Future<void> _disposeCameraController() async {
    log("dispose controller");
    await _cameraController?.dispose();
    _cameraController = null;
    _isCameraControllerDisposed = true;
  }

  @override
  Future<XFile?> takePicture() async {
    log('take');
    try {
      _cameraController!.setFlashMode(FlashMode.off);
      XFile xFile = await _cameraController!.takePicture();
      return xFile;
    } on CameraException catch (e) {
      _updateCameraState(CameraState.error);
      log(e.toString());
      return null;
    }
  }

  @override
  Future<void> startVideoRecording() async {
    await cameraController.prepareForVideoRecording();
    await cameraController.startVideoRecording();
  }

  @override
  Future<XFile?> stopVideoRecording() async {
    return await cameraController.stopVideoRecording();
  }
}
