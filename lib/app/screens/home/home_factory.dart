import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../services/iauth_service.dart';
import 'home_view.dart';
import 'home_view_model.dart';

class HomeFactory {
  static Widget build() {
    return ChangeNotifierProvider(
      create: (context) =>
          HomeViewModel(authService: context.read<IAuthService>()),
      child: Consumer<HomeViewModel>(
        builder: (context, model, child) => HomeView(viewModel: model),
      ),
    );
  }
}
