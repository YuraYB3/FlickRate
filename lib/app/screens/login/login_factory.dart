import 'package:flickrate/app/routing/inavigation_util.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'login_view.dart';
import 'login_view_model.dart';

class LoginFactory {
  static Widget build() {
    return ChangeNotifierProvider(
      create: (context) =>
          LoginViewModel(navigationUtil: context.read<INavigationUtil>()),
      child: Consumer<LoginViewModel>(
        builder: (context, value, child) => LoginView(model: value),
      ),
    );
  }
}
