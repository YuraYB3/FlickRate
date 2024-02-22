import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../services/iuser_service.dart';
import '../../theme/color_palete.dart';
import 'home_view.dart';
import 'home_view_model.dart';

class HomeFactory {
  static Widget build() {
    return ChangeNotifierProvider(
      create: (context) => HomeViewModel(
        userService: context.read<IUserService>(),
      ),
      child: Consumer<HomeViewModel>(
        builder: (context, model, child) =>
            HomeView(model: model, colorsPalete: ColorsPalete()),
      ),
    );
  }
}
