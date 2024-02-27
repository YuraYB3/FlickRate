import 'package:flickrate/app/routing/inavigation_util.dart';
import 'package:flickrate/app/routing/routes.dart';
import 'package:flutter/material.dart';

import '../../../domain/movies/imovie.dart';

class HomeViewModel extends ChangeNotifier {
  final INavigationUtil _navigationUtil;
  late Stream<List<IMovie>> _movieStreamList;

  Stream<List<IMovie>> get movieStreamList => _movieStreamList;

  HomeViewModel({
    required INavigationUtil navigationUtil,
  }) : _navigationUtil = navigationUtil;

  void onAddButtonClicked() {
    _navigationUtil.navigateTo(routeCreateMovie);
  }

  //Move to other view model
  /*void onListTileClicked(IMovie movie) async {
    await _navigationUtil.navigateTo(routeMovie,
        allowBackNavigation: true, data: movie);
  }*/
  /*getItems();
  Future<void> getItems() async {
    _movieStreamList = _movieRepository.fetchMoviesStream();
    notifyListeners();
  }*/
}
