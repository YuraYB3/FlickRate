import 'package:flickrate/app/routing/inavigation_util.dart';
import 'package:flickrate/app/routing/routes.dart';
import 'package:flutter/material.dart';

import '../../../data/movies/movie_repository.dart';
import '../../../domain/movies/imovie.dart';
import '../../services/user/iuser_service.dart';

class HomeViewModel extends ChangeNotifier {
  final IUserService _userService;
  final INavigationUtil _navigationUtil;
  final MovieRepository _movieRepository;
  late Stream<List<IMovie>> _movieStreamList;

  Stream<List<IMovie>> get movieList => _movieStreamList;

  HomeViewModel(
      {required INavigationUtil navigationUtil,
      required IUserService userService,
      required MovieRepository movieRepository})
      : _userService = userService,
        _navigationUtil = navigationUtil,
        _movieRepository = movieRepository {
    getItems();
  }

  void onLogOutButtonPressed(BuildContext context) async {
    _userService.logOut();
  }

  Future<void> getItems() async {
    _movieStreamList = _movieRepository.fetchMoviesStream();
    notifyListeners();
  }

  void onFloatingButtonClicked() {
    _navigationUtil.navigateTo(routeAddMovie);
  }

  void onListTileClicked(IMovie movie) async {
    await _movieRepository.deleteMovie(movie);
  }
}
