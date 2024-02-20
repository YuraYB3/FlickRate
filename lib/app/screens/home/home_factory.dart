import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../domain/local_storage/ilocal_storage.dart';
import '../../services/iuser_service.dart';
import '../../theme/color_palete.dart';
import 'home_view.dart';
import 'home_view_model.dart';

class HomeFactory {
  static Widget build() {
    return ChangeNotifierProvider(
      create: (context) => HomeViewModel(
          userService: context.read<IUserService>(),
          localStorage: context.read<ILocalStorage>()),
      child: Consumer<HomeViewModel>(
        builder: (context, model, child) =>
            HomeView(viewModel: model, colorsPalete: ColorsPalete()),
      ),
    );
  }
}
