import 'package:flickrate/app/services/notification/inotification_service.dart';
import 'package:flutter/material.dart';

import '../home/home_factory.dart';
import '../profile/profile_factory.dart';

class CoreNavigationViewModel extends ChangeNotifier {
  int _selectedIndex = 0;
  int get selectedIndex => _selectedIndex;

  final List<Widget> _pages = [HomeFactory.build(), ProfileFactory.build()];
  List<Widget> get pages => _pages;

  final INotificationService _notificationService;

  CoreNavigationViewModel({required INotificationService notificationService})
      : _notificationService = notificationService {
    _init();
  }
  void _init() async {
    await _notificationService.initialize();
  }

  void updateSelectedIndex(int index) {
    _selectedIndex = index;
    notifyListeners();
  }
}
