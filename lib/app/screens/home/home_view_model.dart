import 'package:flickrate/app/routing/inavigation_util.dart';
import 'package:flickrate/app/routing/routes.dart';
import 'package:flutter/material.dart';

import '../../../data/movies/movie_repository.dart';
import '../../../domain/movies/imovie.dart';

class HomeViewModel extends ChangeNotifier {
  final INavigationUtil _navigationUtil;
  final MovieRepository _movieRepository;
  late Stream<List<IMovie>> _movieStreamList;

  Stream<List<IMovie>> get movieStreamList => _movieStreamList;

  HomeViewModel(
      {required INavigationUtil navigationUtil,
      required MovieRepository movieRepository})
      : _navigationUtil = navigationUtil,
        _movieRepository = movieRepository {
    getItems();
  }

  Future<void> getItems() async {
    _movieStreamList = _movieRepository.fetchMoviesStream();
    notifyListeners();
  }

  void onAddButtonClicked() {
    _navigationUtil.navigateTo(routeCreateMovie);
  }

  /*void onListTileClicked(IMovie movie) async {
    await _navigationUtil.navigateTo(routeMovie,
        allowBackNavigation: true, data: movie);
  }*/
  /* void onLogOutButtonPressed(BuildContext context) async {
    _userService.logOut();
  }*/
}
