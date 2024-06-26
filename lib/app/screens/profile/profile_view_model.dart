import 'dart:developer';

import 'package:flickrate/domain/language/ilanguage_service.dart';
import 'package:flickrate/domain/navigation/inavigation_util.dart';
import 'package:flickrate/app/routing/routes.dart';
import 'package:flickrate/app/screens/camera/camera_view_model.dart';
import 'package:flickrate/domain/user/i_my_user_repository.dart';
import 'package:flickrate/utils/permission_handler.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import '../../../domain/user/i_my_user.dart';
import '../../../domain/user_service/iuser_service.dart';

enum ProfileViewState { readyToWork, loadingInfo }

class ProfileViewModel extends ChangeNotifier {
  final IUserService _userService;
  final IMyUserRepository _myUserRepository;
  final PermissionHandler _permissionHandler;
  final INavigationUtil _navigationUtil;
  final ILanguageService _languageService;
  late Stream<IMyUser> _userStream;
  late IMyUser _myUser;
  String _userNickName = '';
  ProfileViewState _profileViewState = ProfileViewState.loadingInfo;
  bool _isEditInfoClicked = false;
  Stream<IMyUser> get userStream => _userStream;
  bool get isEditInfoClicked => _isEditInfoClicked;
  ProfileViewState get profileViewState => _profileViewState;

  ProfileViewModel(
      {required PermissionHandler permissionHandler,
      required IMyUserRepository myUserRepository,
      required IUserService userService,
      required INavigationUtil navigationUtil,
      required ILanguageService languageService})
      : _userService = userService,
        _permissionHandler = permissionHandler,
        _myUserRepository = myUserRepository,
        _navigationUtil = navigationUtil,
        _languageService = languageService {
    _init();
  }

  void _init() async {
    String userId = _userService.getCurrentUserId();
    await _fetchUserStream(userId);
  }

  void onLogOutButtonPressed() async {
    try {
      _userService.logOut();
    } catch (e) {
      log(e.toString());
    }
  }

  Future<void> _fetchUserStream(String userId) async {
    try {
      _userStream = _myUserRepository.fetchCurrentUser(userId);
      _myUser = await _userStream.first;
      _profileViewState = ProfileViewState.readyToWork;
      notifyListeners();
    } catch (e) {
      _profileViewState = ProfileViewState.loadingInfo;
      notifyListeners();
      log(e.toString());
    }
  }

  void onChoosePhotoFromGalleryClicked(
      {required Function(String message) showException,
      required Function(String message) showSuccess}) async {
    try {
      PermissionState state =
          await _permissionHandler.isGalleryPermissionGranted();
      log('$state');
      switch (state) {
        case PermissionState.granted:
          _choosePhotoFromGallery(showSuccess: showSuccess);
          break;
        case PermissionState.denied:
          showException("Permission not allowed");
          _navigationUtil.navigateBack();
          break;
        default:
          _navigationUtil.navigateBack();
          showException("Permission restricted! Allow it in settings!");
      }
    } catch (e) {
      log(e.toString());
    }
  }

  void _choosePhotoFromGallery(
      {required Function(String message) showSuccess}) async {
    String userId = _myUser.userId;
    String imageName = "profile_image$userId.jpg";
    XFile? image = await _myUserRepository.pickImageFromGallery();
    if (image != null) {
      _navigationUtil.navigateBack();
      onEditInfoButtonClicked();
      showSuccess("Photo successfully updated! Please wait");
      await _myUserRepository.changeProfilePhoto(
          _myUser.documentId, imageName, image.path);
    } else {
      _navigationUtil.navigateBack();
    }
  }

  void onMadePhotoByCameraClicked(
      {required Function(String message) showException}) async {
    try {
      PermissionState state =
          await _permissionHandler.isCameraPermissionGranted();
      log('$state');
      switch (state) {
        case PermissionState.granted:
          String userId = _myUser.userId;
          String imageName = "profile_image$userId.jpg";
          _navigationUtil.navigateTo(
            routeCamera,
            data: {
              "imageName": imageName,
              "documentId": _myUser.documentId,
              "cameraTask": CameraTask.updateProfileImage
            },
          );
          onEditInfoButtonClicked();
          break;
        case PermissionState.denied:
          showException("Permission not allowed");
          _navigationUtil.navigateBack();
          break;
        default:
          _navigationUtil.navigateBack();
          showException("Permission restricted! Allow it in settings!");
      }
    } catch (e) {
      log(e.toString());
    }
  }

  void onEditInfoButtonClicked() {
    _isEditInfoClicked = !_isEditInfoClicked;
    notifyListeners();
  }

  void updateUserNickNameField(String value) {
    _userNickName = value;
    notifyListeners();
  }

  void onChangeUserNickNameClicked(
      {required Function(String message) showException}) {
    if (_userNickName.isNotEmpty) {
      _myUserRepository.updateUserNickName(_userNickName, _myUser.documentId);
      onEditInfoButtonClicked();
    } else {
      showException("Empty field");
    }
  }

  void onChangeLanguageTap() {
    if (_languageService.currentLocale == const Locale('en')) {
      _languageService.changeLanguage('uk');
    } else {
      _languageService.changeLanguage('en');
    }
  }
}
