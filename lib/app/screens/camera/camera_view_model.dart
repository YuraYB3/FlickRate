import 'dart:async';

import 'package:camera/camera.dart';
import 'package:flickrate/app/routing/inavigation_util.dart';
import 'package:flickrate/domain/camera/icamera_service.dart';
import 'package:flickrate/domain/user/i_my_user_repository.dart';
import 'package:flutter/material.dart';


class CameraViewModel extends ChangeNotifier {
  final ICameraService _cameraService;
  final INavigationUtil _navigationUtil;
  final IMyUserRepository _myUserRepository;
  String? imagePath = '';
  XFile? file;
  String imageName;
  String documentId;
  CameraViewModel({
    required ICameraService cameraService,
    required INavigationUtil navigationUtil,
    required this.imageName,
    required this.documentId,
    required IMyUserRepository myUserRepository
  }):
    _cameraService = cameraService,
    _navigationUtil = navigationUtil,
    _myUserRepository = myUserRepository;
  

  Widget get cameraPreview => _cameraService.cameraPreview;

  Stream<CameraState> get cameraStateStream => _cameraService.cameraStateStream;
      
  void disposeCamera(){
    _cameraService.dispose();
  }

  Future<void> init() async{
    _cameraService.initCamera();
  }

  void onToggleCameraClicked() {
    _cameraService.toggleCamera();
  }

  Future<void> onTakePhotoClicked({required Function(String message) showException, required Function() showPicture}) async {
    file = await _cameraService.takePicture();
    if (file!=null) {
      imagePath = file!.path;
      showPicture();
    }
    else{
      showException("Something went wrong");
      _navigationUtil.navigateBack();
    }
  }
  onClosePictureClicked(){
    _navigationUtil.navigateBack();
  }
  onApplyPictureClicked({required Function(String message) showSuccess}){
    _myUserRepository.changeProfilePhoto(documentId, imageName, file!);
    showSuccess("Photo successfully updated! Please wait");
    _navigationUtil.navigateBackToStart();
  }
}