import 'package:flutter/material.dart';

import '../../routing/inavigation_util.dart';
import '../../routing/routes.dart';

class HomeViewModel extends ChangeNotifier {
  final INavigationUtil _navigationUtil;

  HomeViewModel({
    required INavigationUtil navigationUtil,
  }) : _navigationUtil = navigationUtil;

  void onAddButtonClicked() {
    _navigationUtil.navigateTo(routeCreateMovie);
  }

  void onShowAllClicked() {
    _navigationUtil.navigateTo(routeShowAllMovies);
  }
}
