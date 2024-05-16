import 'package:flickrate/domain/navigation/inavigation_util.dart';
import 'package:flickrate/domain/user/i_my_user_repository.dart';
import 'package:flickrate/locator.dart';
import 'package:flickrate/utils/permission_handler.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../domain/user_service/iuser_service.dart';
import 'profile_screen.dart';
import 'profile_view_model.dart';

class ProfileFactory {
  static Widget build() {
    return ChangeNotifierProvider(
      create: (context) => ProfileViewModel(
          permissionHandler: locator<PermissionHandler>(),
          userService: locator<IUserService>(),
          myUserRepository: locator<IMyUserRepository>(),
          navigationUtil: locator<INavigationUtil>()),
      child: Consumer<ProfileViewModel>(
        builder: (context, model, child) => ProfileScreen(model: model),
      ),
    );
  }
}
