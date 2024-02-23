import 'package:flickrate/app/routing/inavigation_util.dart';
import 'package:flickrate/app/routing/routes.dart';
import 'package:flickrate/data/movie.dart';
import 'package:flutter/material.dart';

import '../../services/iuser_service.dart';

class HomeViewModel extends ChangeNotifier {
  final IUserService _userService;
  final INavigationUtil _navigationUtil;
  final MovieModel _movieModel = MovieModel();
  late Stream<List<Movie>> _movieList;

  Stream<List<Movie>> get movieList => _movieList;

  HomeViewModel(
      {required INavigationUtil navigationUtil,
      required IUserService userService})
      : _userService = userService,
        _navigationUtil = navigationUtil {
    getItems();
  }

  void onLogOutButtonPressed(BuildContext context) async {
    _userService.logOut();
  }

  Future<void> getItems() async {
    _movieList = _movieModel.getMovies();
    notifyListeners();
  }

  void onFloatingButtonClicked() {
    _navigationUtil.navigateTo(routeAddMovie);
  }
}
