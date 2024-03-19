import 'package:flickrate/app/services/user/iuser_service.dart';
import 'package:flickrate/domain/user/i_my_user_repository.dart';
import 'package:flickrate/locator.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../routing/inavigation_util.dart';
import 'home_view.dart';
import 'home_view_model.dart';

class HomeFactory {
  static Widget build() {
    return ChangeNotifierProvider(
      create: (context) => HomeViewModel(
          userService: context.read<IUserService>(),
          navigationUtil: context.read<INavigationUtil>(),
          myUserRepository: locator<IMyUserRepository>()),
      child: Consumer<HomeViewModel>(
        builder: (context, model, child) => HomeView(model: model),
      ),
    );
  }
}
