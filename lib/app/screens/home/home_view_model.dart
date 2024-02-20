import 'package:flutter/material.dart';

import '../../../domain/local_storage/ilocal_storage.dart';
import '../../services/iuser_service.dart';
import '../../services/local_storage/keys.dart';

class HomeViewModel extends ChangeNotifier {
  final IUserService _userService;
  final ILocalStorage _localStorage;
  String phoneNumber = '';

  HomeViewModel(
      {required IUserService userService, required ILocalStorage localStorage})
      : _userService = userService,
        _localStorage = localStorage;

  void onLogOutButtonPressed(BuildContext context) async {
    _userService.logout();
  }

  Future<void> loadPhoneNumber() async {
    phoneNumber = await _localStorage.read(keyPhone);
    notifyListeners();
  }
}
