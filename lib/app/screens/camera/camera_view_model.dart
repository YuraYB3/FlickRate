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
  bool _isRecording = false;
  bool get isRecording => _isRecording;
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
    try {
      print('CLICKED');
      _swapIsTakePictureClicked();
      print('SWAP');
      await _cameraService.takePicture().then(
        (file) {
          if (file != null) {
            imagePath = file.path;
            print(imagePath);
            showPicture();
            _swapIsTakePictureClicked();
          } else {
            showException("Something went wrong");
            _swapIsTakePictureClicked();
            _navigationUtil.navigateBack();
          }
        },
      );
    } catch (e) {
      print(e.toString());
    }
  }

  Future<void> onRecordVideoClicked(
      {required Function(String message) showException,
      required Function() showVideo}) async {
    try {
      if (isRecording) {
        //stop recording
        file = await _cameraService.stopVideoRecording();
        showVideo();
      } else {
        // start recording
        await _cameraService.startVideoRecording();
      }
      _isRecording = !isRecording;
      notifyListeners();
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
      showSuccess("Video is loading! Please wait");
      _navigationUtil.navigateBackToStart();
      await _videoRepository.uploadVideo(file!.path);
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
    _isRecording = false;
    notifyListeners();
  }
}
