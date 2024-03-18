import 'package:flickrate/app/services/local_storage/keys.dart';
import 'package:flickrate/domain/local_storage/ilocal_storage.dart';
import 'package:flutter/material.dart';

import '../../routing/inavigation_util.dart';
import '../../routing/routes.dart';

enum HomeViewState { readyToWork, loadingInfo }

class HomeViewModel extends ChangeNotifier {
  final INavigationUtil _navigationUtil;
  final ILocalStorage _localStorage;
  late String imgURL = '';
  late String userName = '';
  HomeViewState homeState = HomeViewState.loadingInfo;

  HomeViewModel({
    required INavigationUtil navigationUtil,
    required ILocalStorage localStorage,
  })  : _navigationUtil = navigationUtil,
        _localStorage = localStorage {
    _init();
  }

  void onAddButtonClicked() {
    _navigationUtil.navigateTo(routeCreateMovie);
  }

  void onShowAllClicked() {
    _navigationUtil.navigateTo(routeShowMovies, data: '');
  }

  void onGenreTileClicked(String genreName) {
    _navigationUtil.navigateTo(routeShowMovies, data: genreName);
  }

  Future<void> _init() async {
    try {
      imgURL = await _localStorage.read(keyProfileImage);
      userName = await _localStorage.read(keyProfileName);
      notifyListeners();
      await _changeIsInfoLoadedState();
    } catch (e) {
      print('Exception');
      print(e.toString());
    }
  }

  Future<void> _changeIsInfoLoadedState() async {
    homeState = HomeViewState.readyToWork;
    notifyListeners();
  }
}
