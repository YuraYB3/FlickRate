import 'package:flickrate/app/routing/inavigation_util.dart';
import 'package:flickrate/utils/permission_handler.dart';
import 'package:flutter/material.dart';

import '../../routing/routes.dart';
import '../home/home_factory.dart';
import '../profile/profile_factory.dart';

class CoreNavigationViewModel extends ChangeNotifier {
  final PermissionHandler _permissionHandler;
  final INavigationUtil _navigationUtil;
  double iconSize = 30;
  int _selectedIndex = 0;
  int get selectedIndex => _selectedIndex;

  final List<Widget> _pages = [HomeFactory.build(), ProfileFactory.build()];
  List<Widget> get pages => _pages;

  CoreNavigationViewModel(
      {required PermissionHandler permissionHandler,
      required INavigationUtil navigationUtil})
      : _permissionHandler = permissionHandler,
        _navigationUtil = navigationUtil {
    _init();
  }
  void _init() async {
    await _permissionHandler.askCorePermissions();
  }

  void updateSelectedIndex(int index) {
    _selectedIndex = index;
    notifyListeners();
  }

  void onFloatingButtonClicked() {
    _navigationUtil.navigateTo(routeCreateMovie);
  }
}
