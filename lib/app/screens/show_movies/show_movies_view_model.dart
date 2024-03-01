import 'package:flickrate/domain/movies/imovie_repository.dart';
import 'package:flutter/material.dart';

import '../../../domain/movies/imovie.dart';
import '../../routing/inavigation_util.dart';
import '../../routing/routes.dart';

class ShowMoviesViewModel extends ChangeNotifier {
  late Stream<List<IMovie>> _movieStreamList;
  Stream<List<IMovie>> get movieStreamList => _movieStreamList;

  final INavigationUtil _navigationUtil;
  final IMovieRepository _movieRepository;
  final String _genre;

  ShowMoviesViewModel(
      {required IMovieRepository movieRepository,
      required INavigationUtil navigationUtil,
      required String genre})
      : _navigationUtil = navigationUtil,
        _movieRepository = movieRepository,
        _genre = genre {
    fetchMoviesStream();
  }

  void onListTileClicked(String movieId) async {
    await _navigationUtil.navigateTo(routeMovie,
        allowBackNavigation: true, data: movieId);
  }

  Future<void> fetchMoviesStream() async {
    if (_genre.isEmpty) {
      _movieStreamList = _movieRepository.fetchMoviesStream();
    } else {
      _movieStreamList = _movieRepository.fetchMoviesStreamByGenre(_genre);
    }
    notifyListeners();
  }
}
