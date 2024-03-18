// ignore_for_file: avoid_print
import 'package:flickrate/app/services/local_storage/keys.dart';
import 'package:flickrate/domain/local_storage/ilocal_storage.dart';
import 'package:flickrate/domain/user/i_my_user_repository.dart';
import 'package:flickrate/utils/permission_handler.dart';
import 'package:flutter/material.dart';

import '../../services/user/iuser_service.dart';

class ProfileViewModel extends ChangeNotifier {
  final IUserService _userService;
  final IMyUserRepository _myUserRepository;
  final PermissionHandler _permissionHandler;
  final ILocalStorage _localStorage;
  late String userId;
  late String _documentID;
  String imgURL = '';

  ProfileViewModel(
      {required PermissionHandler permissionHandler,
      required IMyUserRepository myUserRepository,
      required IUserService userService,
      required ILocalStorage localStorage})
      : _userService = userService,
        _permissionHandler = permissionHandler,
        _myUserRepository = myUserRepository,
        _localStorage = localStorage {
    _init();
  }

  void _init() async {
    await _readUserInfo();
  }

  void onLogOutButtonPressed() async {
    try {
      _userService.logOut();
    } catch (e) {
      print(e.toString());
    }
  }

  void onChangePhotoClicked(
      {required Function(String message) showException}) async {
    try {
      PermissionState state =
          await _permissionHandler.isGalleryPermissionGranted();
      print(state);
      switch (state) {
        case PermissionState.granted:
          String imageName = "profile_image$userId.jpg";
          _myUserRepository.changeProfilePhoto(_documentID, imageName);
          await _readUserInfo();
          break;
        case PermissionState.denied:
          showException("Permission not allowed");
          break;
        default:
          showException("Permission restricted! Allow it in settings!");
      }
    } catch (e) {
      print(e.toString());
    }
  }

  Future<void> _readUserInfo() async {
    userId = await _localStorage.read(keyUserID);
    imgURL = await _localStorage.read(keyProfileImage);
    _documentID = await _localStorage.read(keyProfileDocumentID);
    notifyListeners();
  }
}
