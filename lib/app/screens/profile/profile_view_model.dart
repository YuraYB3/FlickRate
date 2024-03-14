// ignore_for_file: avoid_print

import 'package:flickrate/app/common/widgets/custom_snackbar.dart';
import 'package:flickrate/domain/user/i_my_user.dart';
import 'package:flickrate/domain/user/i_my_user_repository.dart';
import 'package:flickrate/utils/permission_handler.dart';
import 'package:flutter/material.dart';

import '../../services/user/iuser_service.dart';

class ProfileViewModel extends ChangeNotifier {
  final IUserService _userService;
  final IMyUserRepository _myUserRepository;
  final PermissionHandler _permissionHandler;
  late Stream<IMyUser> _userStream;
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

  void _init() {
    String userId = _userService.getCurrentUserId();
    _fetchUserStream(userId);
  }

  void onLogOutButtonPressed() async {
    try {
      _userService.logOut();
    } catch (e) {
      print(e.toString());
    }
  }

  void _fetchUserStream(String userId) async {
    try {
      _userStream = _myUserRepository.fetchCurrentUser(userId);
      _myUser = await _userStream.first;
    } catch (e) {
      print(e.toString());
    }
  }

  void onChangePhotoClicked(BuildContext context) async {
    try {
      PermissionState state =
          await _permissionHandler.isGalleryPermissionGranted();
      switch (state) {
        case PermissionState.granted:
          _myUserRepository.changeProfilePhoto(_myUser.documentId);
          break;
        case PermissionState.notAllowed:
          showCustomSnackBar(context, "Permission not allowed");
          break;
        default:
      }
    } catch (e) {
      print(e.toString());
    }
  }
}
