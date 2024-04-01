// ignore_for_file: avoid_print

import 'package:flutter/material.dart';

import '../../../../domain/movies/imovie.dart';
import '../../../../domain/movies/imovie_repository.dart';
import '../../../routing/inavigation_util.dart';
import '../../../routing/routes.dart';

class ShowMoviesViewModel extends ChangeNotifier {
  late Stream<List<IMovie>> _movieStreamList;
  Stream<List<IMovie>> get movieStreamList => _movieStreamList;

  final INavigationUtil _navigationUtil;
  final IMovieRepository _movieRepository;

  String searchQuery = '';
  ShowMoviesViewModel({
    required IMovieRepository movieRepository,
    required INavigationUtil navigationUtil,
  })  : _navigationUtil = navigationUtil,
        _movieRepository = movieRepository {
    _fetchMoviesStream();
  }

  void onListTileClicked(String movieId) async {
    print(movieId);
    await _navigationUtil.navigateTo(routeMovie, data: movieId);
  }

  Future<void> _fetchMoviesStream() async {
    try {
      _movieStreamList = _movieRepository.fetchMoviesStream();
      notifyListeners();
    } catch (e) {
      print(e.toString());
    }
  }

  void updateSearchQuery(String query) {
    searchQuery = query;
    if (searchQuery.trim().length > 3) {
      _fetchMoviesStreamByQuery(query);
    } else {
      _fetchMoviesStream();
    }
  }

  Future<void> _fetchMoviesStreamByQuery(String query) async {
    try {
      _movieStreamList = _movieRepository.fetchMoviesByName(query);
      notifyListeners();
    } catch (e) {
      print(e.toString());
    }
  }
}
