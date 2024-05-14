import 'dart:developer';

import 'package:flutter/material.dart';

import '../../../../domain/movies/imovie.dart';
import '../../../../domain/movies/imovie_repository.dart';
import '../../../../domain/navigation/inavigation_util.dart';
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
        _movieRepository = movieRepository;

  void onListTileClicked(String movieId) async {
    log(movieId);
    await _navigationUtil.navigateTo(routeMovie, data: movieId);
  }

  Future<void> fetchMoviesStream() async {
    try {
      _movieStreamList = _movieRepository.fetchMoviesStream();
    } catch (e) {
      log(e.toString());
    }
  }

  void updateSearchQuery(String query) {
    searchQuery = query;
    if (searchQuery.trim().length > 3) {
      _fetchMoviesStreamByQuery(query);
    } else if (searchQuery.trim().isEmpty) {
      fetchMoviesStream();
    } else {}
  }

  Future<void> _fetchMoviesStreamByQuery(String query) async {
    try {
      _movieStreamList = _movieRepository.fetchMoviesByName(query);
      notifyListeners();
    } catch (e) {
      log(e.toString());
    }
  }
}
