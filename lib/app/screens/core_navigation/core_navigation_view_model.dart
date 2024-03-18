import 'package:flickrate/domain/notification/inotification_service.dart';
import 'package:flickrate/utils/permission_handler.dart';
import 'package:flutter/material.dart';

import '../home/home_factory.dart';
import '../profile/profile_factory.dart';

class CoreNavigationViewModel extends ChangeNotifier {
  final INotificationService _notificationService;
  final PermissionHandler _permissionHandler;
  int _selectedIndex = 0;
  int get selectedIndex => _selectedIndex;

  final List<Widget> _pages = [HomeFactory.build(), ProfileFactory.build()];
  List<Widget> get pages => _pages;

  CoreNavigationViewModel(
      {required INotificationService notificationService,
      required PermissionHandler permissionHandler})
      : _notificationService = notificationService,
        _permissionHandler = permissionHandler {
    _init();
  }
  void _init() async {
    await _notificationService.initialize();
    await _permissionHandler.askCorePermissions();
  }

  void updateSelectedIndex(int index) {
    _selectedIndex = index;
    notifyListeners();
  }
}
