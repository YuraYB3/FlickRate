import 'package:flickrate/domain/user/i_my_user_repository.dart';
import 'package:flickrate/locator.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../services/user/iuser_service.dart';
import 'login_view.dart';
import 'login_view_model.dart';

class LoginFactory {
  static Widget build() {
    return ChangeNotifierProvider(
      create: (context) => LoginViewModel(
          userService: context.read<IUserService>(),
          myUserRepository: locator<IMyUserRepository>()),
      child: Consumer<LoginViewModel>(
        builder: (context, value, child) => LoginView(model: value),
      ),
    );
  }
}
