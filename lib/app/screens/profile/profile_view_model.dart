// ignore_for_file: avoid_print

import 'package:flickrate/domain/user/i_my_user.dart';
import 'package:flickrate/domain/user/i_my_user_repository.dart';
import 'package:flutter/material.dart';

import '../../services/user/iuser_service.dart';

class ProfileViewModel extends ChangeNotifier {
  final IUserService _userService;
  final IMyUserRepository _myUserRepository;
  late Stream<IMyUser> _userStream;
  late IMyUser _myUser;
  Stream<IMyUser> get userStream => _userStream;

  ProfileViewModel({
    required IMyUserRepository myUserRepository,
    required IUserService userService,
  })  : _userService = userService,
        _myUserRepository = myUserRepository {
    _init();
  }

  void _init() {
    String userId = _userService.getCurrentUserId();
    _fetchUserStream(userId);
  }

  void onLogOutButtonPressed() async {
    _userService.logOut();
  }

  void _fetchUserStream(String userId) async {
    print('Fetching user stream for user with ID: $userId');
    _userStream = _myUserRepository.fetchCurrentUser(userId);
    _myUser = await _userStream.first;
  }

  void onChangePhotoClicked() {
    _myUserRepository.changeProfilePhoto(_myUser.documentId);
  }
}
