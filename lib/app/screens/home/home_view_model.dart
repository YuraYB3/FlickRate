import 'package:flutter/material.dart';

import '../../services/iauth_service.dart';

class HomeViewModel extends ChangeNotifier {
  final IAuthService authService;

  HomeViewModel({required this.authService});

  void onLogOutButtonPressed(BuildContext context) async {
    await authService.logOut();
  }
}
