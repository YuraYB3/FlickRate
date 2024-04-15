import 'package:flickrate/app/routing/inavigation_util.dart';
import 'package:flickrate/domain/local_notification/ilocal_notification_service.dart';
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
          localNotification: locator<ILocalNotificationService>(),
          permissionHandler: locator<PermissionHandler>(),
          userService: locator<IUserService>(),
          myUserRepository: locator<IMyUserRepository>(),
          navigationUtil: context.read<INavigationUtil>()),
      child: Consumer<ProfileViewModel>(
        builder: (context, model, child) => ProfileView(model: model),
      ),
    );
  }
}
