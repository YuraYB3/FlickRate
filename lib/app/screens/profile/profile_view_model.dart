// ignore_for_file: avoid_print
import 'package:flickrate/domain/user/i_my_user_repository.dart';
import 'package:flickrate/utils/permission_handler.dart';
import 'package:flutter/material.dart';

import '../../../domain/user/i_my_user.dart';
import '../../services/user/iuser_service.dart';

enum ProfileViewState { readyToWork, loadingInfo }

class ProfileViewModel extends ChangeNotifier {
  final IUserService _userService;
  final IMyUserRepository _myUserRepository;
  final PermissionHandler _permissionHandler;
  late Stream<IMyUser> _userStream;
  late IMyUser _myUser;
  String _userNickName = '';
  ProfileViewState _profileViewState = ProfileViewState.loadingInfo;
  bool _isEditInfoClicked = false;
  Stream<IMyUser> get userStream => _userStream;
  bool get isEditInfoClicked => _isEditInfoClicked;
  ProfileViewState get profileViewState => _profileViewState;

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
      _profileViewState = ProfileViewState.readyToWork;
      notifyListeners();
    } catch (e) {
      _profileViewState = ProfileViewState.loadingInfo;
      notifyListeners();
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
          await _myUserRepository.changeProfilePhoto(
              _myUser.documentId, imageName);
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
}
