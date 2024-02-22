import 'package:flutter/material.dart';

import '../../services/iuser_service.dart';

class HomeViewModel extends ChangeNotifier {
  final IUserService _userService;
  String phoneNumber = '';

  HomeViewModel({required IUserService userService})
      : _userService = userService;

  void onLogOutButtonPressed(BuildContext context) async {
    _userService.logout();
  }
}
