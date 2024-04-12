// ignore_for_file: avoid_print

import 'dart:async';
import 'dart:io';

import 'package:camera/camera.dart';
import 'package:flickrate/app/routing/inavigation_util.dart';
import 'package:flickrate/domain/camera/icamera_service.dart';
import 'package:flickrate/domain/user/i_my_user_repository.dart';
import 'package:flickrate/domain/video/ivideo_repository.dart';
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

enum CameraTask { updateProfileImage, test }

enum ActiveOption { camera, video }

class CameraViewModel extends ChangeNotifier with WidgetsBindingObserver {
  final ICameraService _cameraService;
  final INavigationUtil _navigationUtil;
  final IMyUserRepository _myUserRepository;
  final IVideoRepository _videoRepository;
  final CameraTask cameraTask;

  late void Function() showVideo;
  String? imagePath = '';
  XFile? file;
  String imageName;
  String documentId;
  bool isTakePictureClicked = false;
  bool isRecording = false;
  late VideoPlayerController _videoPlayerController;
  VideoPlayerController get videoPlayerController => _videoPlayerController;
  ActiveOption currentOption = ActiveOption.camera;

  Widget get cameraPreview => _cameraService.cameraPreview;

  Stream<CameraState> get cameraStateStream => _cameraService.cameraStateStream;

  CameraViewModel(
      {required ICameraService cameraService,
      required INavigationUtil navigationUtil,
      required this.imageName,
      required this.documentId,
      required this.cameraTask,
      required IMyUserRepository myUserRepository,
      required IVideoRepository videoRepository})
      : _cameraService = cameraService,
        _navigationUtil = navigationUtil,
        _myUserRepository = myUserRepository,
        _videoRepository = videoRepository;

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.inactive) {
      _navigationUtil.navigateBack();
    }
  }
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

  Future<void> onTakePhotoClicked(
      {required Function(String message) showException,
      required Function() showPicture}) async {
    _swapIsTakePictureClicked();
    file = await _cameraService.takePicture();
    if (file != null) {
      imagePath = file!.path;
      showPicture();
      _swapIsTakePictureClicked();
    } else {
      showException("Something went wrong");
      _navigationUtil.navigateBack();
    }
  }

  Future<void> onRecordVideoClicked(
      {required Function(String message) showException,
      required Function() showVideo}) async {
    try {
      if (isRecording) {
        //stop recording
        await _stopVideoRecording();
        showVideo();
      } else {
        // start recording
        await _cameraService.startVideoRecording();
        isRecording = !isRecording;
        notifyListeners();
      }
    } catch (e) {
      print(e.toString());
      showException("Something went wrong");
    }
  }

  void onClosePictureClicked() {
    _navigationUtil.navigateBack();
  }

  void onApplyPictureClicked({required Function(String message) showSuccess}) {
    switch (cameraTask) {
      case CameraTask.updateProfileImage:
        _myUserRepository.changeProfilePhoto(documentId, imageName, file!);
        showSuccess("Photo successfully updated! Please wait");
        _navigationUtil.navigateBackToStart();
        break;
      case CameraTask.test:
        showSuccess("Camera successfully tested!");
        _navigationUtil.navigateBackToStart();
      default:
    }
  }

  void onCloseVideoClicked() {
    _navigationUtil.navigateBack();
  }

  Future<void> onApplyVideoClicked(
      {required Function(String message) showSuccess}) async {
    if (file != null) {
      try {
        showSuccess("Video successfully added! Please wait");
        _navigationUtil.navigateBackToStart();
        await _videoRepository.uploadVideo(file!);
      } catch (e) {
        print(e.toString());
      }
    } else {
      _navigationUtil.navigateBack();
    }
  }

  void _swapIsTakePictureClicked() {
    isTakePictureClicked = !isTakePictureClicked;
    notifyListeners();
  }

  void onChangeActiveOptionClicked() {
    if (currentOption == ActiveOption.camera) {
      currentOption = ActiveOption.video;
    } else {
      currentOption = ActiveOption.camera;
    }
    isRecording = false;
    notifyListeners();
  }

  Future<void> _stopVideoRecording() async {
    file = await _cameraService.stopVideoRecording();
    isRecording = !isRecording;
    notifyListeners();
  }
}
