import 'package:flutter/material.dart';

import '../../services/iauth_service.dart';

class HomeViewModel extends ChangeNotifier {
  final IAuthService _authService;

  HomeViewModel({required IAuthService authService})
      : _authService = authService;

  void onLogOutButtonPressed(BuildContext context) async {
    await _authService.logOut();
  }
}
