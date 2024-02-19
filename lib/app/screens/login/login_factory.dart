import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../services/iauth_service.dart';
import 'login_view.dart';
import 'login_view_model.dart';

class LoginFactory {
  static Widget build() {
    return ChangeNotifierProvider(
      create: (context) => LoginViewModel(
        authService: context.read<IAuthService>(),
      ),
      child: Consumer<LoginViewModel>(
        builder: (context, value, child) => LoginView(model: value),
      ),
    );
  }
}
