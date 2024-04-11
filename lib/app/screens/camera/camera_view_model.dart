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

class CameraViewModel extends ChangeNotifier {
  final ICameraService _cameraService;
  final INavigationUtil _navigationUtil;
  final IMyUserRepository _myUserRepository;
  final IVideoRepository _videoRepository;
  final CameraTask cameraTask;
  String? imagePath = '';
  XFile? file;
  String imageName;
  String documentId;
  bool isTakePictureClicked = false;
  bool isRecordVideoClicked = false;
  late VideoPlayerController videoPlayerController;

  ActiveOption currentOption = ActiveOption.camera;
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

  Widget get cameraPreview => _cameraService.cameraPreview;

  Stream<CameraState> get cameraStateStream => _cameraService.cameraStateStream;

  Future<void> initCamera() async {
    _cameraService.initCamera();
  }

  void disposeCamera() {
    _cameraService.dispose();
  }

  Future<void> initVideoController() async {
    videoPlayerController = VideoPlayerController.file(File(file!.path));
    await videoPlayerController.initialize();
    await videoPlayerController.setLooping(true);
    await videoPlayerController.play();
  }

  void disposeVideoController() {
    videoPlayerController.dispose();
  }

  void onToggleCameraClicked() {
    _cameraService.toggleCamera();
  }

  Future<void> onTakePhotoClicked(
      {required Function(String message) showException,
      required Function() showPicture}) async {
    _swapIsTakePictureClickedState();
    file = await _cameraService.takePicture();
    if (file != null) {
      imagePath = file!.path;
      showPicture();
      _swapIsTakePictureClickedState();
    } else {
      showException("Something went wrong");
      _navigationUtil.navigateBack();
    }
  }

  Future<void> onRecordVideoClicked(
      {required Function(String message) showException,
      required Function() showVideo}) async {
    try {
      if (isRecordVideoClicked) {
        //start recording
        file = await _cameraService.cameraController.stopVideoRecording();
        isRecordVideoClicked = !isRecordVideoClicked;
        notifyListeners();
        showVideo();
      } else {
        // end recording
        await _cameraService.cameraController.prepareForVideoRecording();
        await _cameraService.cameraController.startVideoRecording();
        isRecordVideoClicked = !isRecordVideoClicked;
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

  void _swapIsTakePictureClickedState() {
    isTakePictureClicked = !isTakePictureClicked;
    notifyListeners();
  }

  void onChangeActiveOptionClicked() {
    if (currentOption == ActiveOption.camera) {
      currentOption = ActiveOption.video;
    } else {
      currentOption = ActiveOption.camera;
    }
    isRecordVideoClicked = false;
    notifyListeners();
  }
}
