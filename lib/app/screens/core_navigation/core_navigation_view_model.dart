import 'package:flickrate/app/screens/movies/show_movies/show_movies_factory.dart';
import 'package:flickrate/app/screens/videos/show_videos_factory.dart';
import 'package:flickrate/utils/permission_handler.dart';
import 'package:flutter/material.dart';

import '../home/home_factory.dart';
import '../profile/profile_factory.dart';

class CoreNavigationViewModel extends ChangeNotifier {
  final PermissionHandler _permissionHandler;
  double iconSize = 30;
  int _selectedIndex = 0;
  int get selectedIndex => _selectedIndex;

  final List<Widget> _pages = [
    HomeFactory.build(),
    ShowMoviesFactory.build(""),
    ShowVideosFactory.build(),
    ProfileFactory.build(),
    
  ];
  List<Widget> get pages => _pages;

  CoreNavigationViewModel({
    required PermissionHandler permissionHandler,
  }) : _permissionHandler = permissionHandler {
    _init();
  }
  void _init() async {
    await _permissionHandler.askCorePermissions();
  }

  void updateSelectedIndex(int index) {
    _selectedIndex = index;
    notifyListeners();
  }
}
