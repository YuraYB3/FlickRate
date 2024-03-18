import 'package:flickrate/domain/local_storage/ilocal_storage.dart';
import 'package:flickrate/domain/user/i_my_user_repository.dart';
import 'package:flickrate/locator.dart';
import 'package:flickrate/utils/permission_handler.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../services/user/iuser_service.dart';
import 'profile_view.dart';
import 'profile_view_model.dart';

class ProfileFactory {
  static Widget build() {
    return ChangeNotifierProvider(
        create: (context) => ProfileViewModel(
            localStorage: locator<ILocalStorage>(),
            permissionHandler: locator<PermissionHandler>(),
            userService: context.read<IUserService>(),
            myUserRepository: locator<IMyUserRepository>()),
        child: Consumer<ProfileViewModel>(
          builder: (context, model, child) => ProfileView(model: model),
        ));
  }
}
