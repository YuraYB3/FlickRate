import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../services/user/iuser_service.dart';
import 'profile_view.dart';
import 'profile_view_model.dart';

class ProfileFactory {
  static Widget build() {
    return ChangeNotifierProvider(
        create: (context) => ProfileViewModel(
              userService: context.read<IUserService>(),
            ),
        child: Consumer<ProfileViewModel>(
          builder: (context, model, child) => ProfileView(model: model),
        ));
  }
}
