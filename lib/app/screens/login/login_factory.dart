import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../domain/auth/iauth_service.dart';
import '../../../domain/local_storage/ilocal_storage.dart';
import 'login_view.dart';
import 'login_view_model.dart';

class LoginFactory {
  static Widget build() {
    return ChangeNotifierProvider(
      create: (context) => LoginViewModel(
          authService: context.read<IAuthService>(),
          localStorage: context.read<ILocalStorage>()),
      child: Consumer<LoginViewModel>(
        builder: (context, value, child) => LoginView(model: value),
      ),
    );
  }
}
