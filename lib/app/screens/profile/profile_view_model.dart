// ignore_for_file: avoid_print
import 'package:flickrate/domain/user/i_my_user_repository.dart';
import 'package:flickrate/utils/permission_handler.dart';
import 'package:flutter/material.dart';

import '../../../domain/user/i_my_user.dart';
import '../../services/user/iuser_service.dart';

class ProfileViewModel extends ChangeNotifier {
  final IUserService _userService;
  final IMyUserRepository _myUserRepository;
  final PermissionHandler _permissionHandler;
  late Stream<IMyUser> _userStream;
  late String imgURL = '';
  late IMyUser _myUser;
  Stream<IMyUser> get userStream => _userStream;

  ProfileViewModel({
    required PermissionHandler permissionHandler,
    required IMyUserRepository myUserRepository,
    required IUserService userService,
  })  : _userService = userService,
        _permissionHandler = permissionHandler,
        _myUserRepository = myUserRepository {
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
      print(e.toString());
    }
  }

  Future<void> _fetchUserStream(String userId) async {
    try {
      _userStream = _myUserRepository.fetchCurrentUser(userId);
      _myUser = await _userStream.first;
      imgURL = _myUser.userProfileImage;
      notifyListeners();
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
          String userId = _myUser.userId;
          String imageName = "profile_image$userId.jpg";
          await _myUserRepository
              .changeProfilePhoto(_myUser.documentId, imageName)
              .then((value) => _init());
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
}
