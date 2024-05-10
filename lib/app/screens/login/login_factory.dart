import 'package:flickrate/locator.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../services/user/iuser_service.dart';
import 'login_screen.dart';
import 'login_view_model.dart';

class LoginFactory {
  static Widget build() {
    return ChangeNotifierProvider(
      create: (context) => LoginViewModel(userService: locator<IUserService>()),
      child: Consumer<LoginViewModel>(
        builder: (context, value, child) => LoginScreen(model: value),
      ),
    );
  }
}
