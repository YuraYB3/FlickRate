import 'package:flickrate/app/services/iauth_service.dart';
import 'package:flutter/material.dart';

class HomeViewModel extends ChangeNotifier {
  final IAuthService authService;

  HomeViewModel({required this.authService});

  void onLogOutButtonPressed(BuildContext context) async {
    await authService.logOut();
  }
}
