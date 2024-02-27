import 'package:flutter/material.dart';

import '../../services/user/iuser_service.dart';

class ProfileViewModel extends ChangeNotifier {
  final IUserService _userService;

  ProfileViewModel({required IUserService userService})
      : _userService = userService;
  void onLogOutButtonPressed() async {
    _userService.logOut();
  }
}
