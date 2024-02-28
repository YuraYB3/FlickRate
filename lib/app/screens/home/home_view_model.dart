import 'package:flickrate/app/routing/inavigation_util.dart';
import 'package:flickrate/app/routing/routes.dart';
import 'package:flutter/material.dart';

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
