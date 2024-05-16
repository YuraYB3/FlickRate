import 'dart:async';
import 'dart:developer';
import 'dart:io';
import 'package:camera/camera.dart';
import 'package:flickrate/domain/navigation/inavigation_util.dart';
import 'package:flickrate/domain/camera/icamera_service.dart';
import 'package:flickrate/domain/user/i_my_user_repository.dart';
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

enum CameraTask { updateProfileImage, test }

enum ActiveOption { camera, video }

class CameraViewModel extends ChangeNotifier with WidgetsBindingObserver {
  final ICameraService _cameraService;
  final INavigationUtil _navigationUtil;
  final IMyUserRepository _myUserRepository;
  // final IVideoRepository _videoRepository;
  final CameraTask cameraTask;

  String? imagePath = '';
  XFile? file;
  String imageName;
  String documentId;
  // final int _recordDurationLimit = 15;
  // Timer? recordingTimer;

  ActiveOption _currentOption = ActiveOption.camera;
  ActiveOption get currentOption => _currentOption;

  final ValueNotifier<double> _recordingDuration = ValueNotifier(0);
  ValueNotifier<double> get recordingDuration => _recordingDuration;

  bool _isTakePictureClicked = false;
  bool get isTakePictureClicked => _isTakePictureClicked;

  bool _isRecording = false;
  bool get isRecording => _isRecording;

  late VideoPlayerController _videoPlayerController;
  VideoPlayerController get videoPlayerController => _videoPlayerController;

  Widget get cameraPreview => _cameraService.cameraPreview;
  Stream<CameraState> get cameraStateStream => _cameraService.cameraStateStream;
  CameraController get cameraController => _cameraService.cameraController;

  CameraViewModel({
    required ICameraService cameraService,
    required INavigationUtil navigationUtil,
    required this.imageName,
    required this.documentId,
    required this.cameraTask,
    required IMyUserRepository myUserRepository,
  })  : _cameraService = cameraService,
        _navigationUtil = navigationUtil,
        _myUserRepository = myUserRepository;

  Future<void> initCamera() async {
    _cameraService.initCamera();
  }

  void disposeCamera() {
    _cameraService.dispose();
  }

  Future<void> initVideoController() async {
    _videoPlayerController = VideoPlayerController.file(File(file!.path));
    await _videoPlayerController.initialize();
    await _videoPlayerController.setLooping(true);
    await _videoPlayerController.play();
  }

  void disposeVideoController() {
    _videoPlayerController.dispose();
  }

  void onToggleCameraClicked() {
    _cameraService.toggleCamera();
  }

  void onChangeActiveOptionClicked() {
    _currentOption = currentOption == ActiveOption.camera
        ? ActiveOption.video
        : ActiveOption.camera;
    _isRecording = false;
    notifyListeners();
  }

  Future<void> onTakePhotoClicked({
    required Function(String message) showException,
    required Function() showPicture,
  }) async {
    try {
      _swapIsTakePictureClicked();
      final file = await _cameraService.takePicture();
      if (file != null) {
        imagePath = file.path;
        log('$imagePath');
        showPicture();
        _swapIsTakePictureClicked();
      } else {
        showException("Something went wrong");
        _swapIsTakePictureClicked();
        _navigationUtil.navigateBack();
      }
    } catch (e) {
      log(e.toString());
    }
  }

  void onClosePictureClicked() {
    _navigationUtil.navigateBack();
  }

  void onApplyPictureClicked({
    required Function(String message) showSuccess,
  }) {
    switch (cameraTask) {
      case CameraTask.updateProfileImage:
        _myUserRepository.changeProfilePhoto(documentId, imageName, imagePath!);
        showSuccess("Photo successfully updated! Please wait");
        _navigationUtil.navigateBackToStart();
        break;
      case CameraTask.test:
        showSuccess("Camera successfully tested!");
        _navigationUtil.navigateBackToStart();
        break;
      default:
    }
  }

  void _swapIsTakePictureClicked() {
    _isTakePictureClicked = !isTakePictureClicked;
    notifyListeners();
  }
/*
  Future<void> onRecordVideoClicked({
    required Function(String message) showException,
    required Function() showVideo,
  }) async {
    try {
      if (isRecording) {
        // Stop recording
        _stopRecording(showVideo: showVideo);
      } else {
        // Start recording
        _startVideoRecording(
            showException: showException, showVideo: showVideo);
      }
      _isRecording = !isRecording;
      notifyListeners();
    } catch (e) {
      log(e.toString());
      showException("Something went wrong");
    }
  }

  void _startVideoRecording({
    required Function(String message) showException,
    required Function() showVideo,
  }) async {
    await _cameraService.startVideoRecording();
    _startTimer(showException: showException, showVideo: showVideo);
  }

  void _stopRecording({required Function() showVideo}) async {
    file = await _cameraService.stopVideoRecording();
    _stopTimerAndResetDuration();
    showVideo();
  }

  void onCloseVideoClicked() {
    _navigationUtil.navigateBack();
  }

  Future<void> onApplyVideoClicked({
    required Function(String message) showSuccess,
  }) async {
    if (file != null) {
      showSuccess("Video is loading! Please wait");
      _navigationUtil.navigateBackToStart();
      await _videoRepository.uploadVideo(file!.path);
    } else {
      _navigationUtil.navigateBack();
    }
  }

  void _startTimer({
    required Function(String message) showException,
    required Function() showVideo,
  }) {
    recordingTimer = Timer.periodic(
      const Duration(milliseconds: 100),
      (timer) {
        _recordingDuration.value += 0.1;
        notifyListeners();
        if (_recordingDuration.value >= _recordDurationLimit) {
          _stopRecording(showVideo: showVideo);
        }
        log("Seconds: ${_recordingDuration.value}");
      },
    );
  }

  void _stopTimerAndResetDuration() {
    recordingTimer?.cancel();
    _recordingDuration.value = 0;
  }*/
}
