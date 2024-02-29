import 'package:flutter/material.dart';

import '../../../data/movies/movie_repository.dart';
import '../../../domain/movies/imovie.dart';
import '../../routing/inavigation_util.dart';
import '../../routing/routes.dart';

class ShowAllMoviesViewModel extends ChangeNotifier {
  late Stream<List<IMovie>> _movieStreamList;
  Stream<List<IMovie>> get movieStreamList => _movieStreamList;

  final INavigationUtil _navigationUtil;
  final MovieRepository _movieRepository;

  ShowAllMoviesViewModel(
      {required MovieRepository movieRepository,
      required INavigationUtil navigationUtil})
      : _navigationUtil = navigationUtil,
        _movieRepository = movieRepository {
    fetchMoviesStream();
  }

  void onListTileClicked(String movieId) async {
    await _navigationUtil.navigateTo(routeMovie,
        allowBackNavigation: true, data: movieId);
  }

  Future<void> fetchMoviesStream() async {
    _movieStreamList = _movieRepository.fetchMoviesStream();
    notifyListeners();
  }
}
