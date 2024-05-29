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
  bool _isSearchButtonClicked = false;

  String _searchQuery = '';
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
      _movieStreamList = _movieRepository.fetchAllMoviesStream();
    } catch (e) {
      log(e.toString());
    }
  }

  void updateSearchQuery(String query) {
    _searchQuery = query;
    if (_searchQuery.isEmpty && _isSearchButtonClicked) {
      fetchMoviesStream();
      _isSearchButtonClicked = false;
      notifyListeners();
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

  void onSearchButtonClicked() {
    if (!_isSearchButtonClicked) {
      if (_searchQuery.trim().length >= 3) {
        _isSearchButtonClicked = true;
        _fetchMoviesStreamByQuery(_searchQuery);
      } else {}
    }
  }
}
