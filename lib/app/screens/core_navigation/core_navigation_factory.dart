import 'package:flickrate/app/routing/inavigation_util.dart';
import 'package:flickrate/locator.dart';
import 'package:flickrate/utils/permission_handler.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'core_navigation_view.dart';
import 'core_navigation_view_model.dart';

class CoreNavigationFactory {
  static Widget build() {
    return ChangeNotifierProvider(
      create: (context) => CoreNavigationViewModel(
        navigationUtil: context.read<INavigationUtil>(),
        permissionHandler: locator<PermissionHandler>(),
      ),
      child: Consumer<CoreNavigationViewModel>(
        builder: (context, model, child) =>
            CoreNavigationView(navigationViewModel: model),
      ),
    );
  }
}
