// ignore_for_file: avoid_print

import 'package:flutter/material.dart';

import '../../../../domain/movies/imovie.dart';
import '../../../../domain/movies/imovie_repository.dart';
import '../../../routing/inavigation_util.dart';
import '../../../routing/routes.dart';
import '../../../services/user/iuser_service.dart';

class ShowMoviesViewModel extends ChangeNotifier {
  late Stream<List<IMovie>> _movieStreamList;
  Stream<List<IMovie>> get movieStreamList => _movieStreamList;

  final INavigationUtil _navigationUtil;
  final IMovieRepository _movieRepository;
  final IUserService _userService;
  final String _genre;
  late String _userId;

  ShowMoviesViewModel(
      {required IMovieRepository movieRepository,
      required IUserService userService,
      required INavigationUtil navigationUtil,
      required String genre})
      : _navigationUtil = navigationUtil,
        _userService = userService,
        _movieRepository = movieRepository,
        _genre = genre {
    fetchMoviesStream();
  }

  void onListTileClicked(String movieId) async {
    await _navigationUtil.navigateTo(routeMovie, data: movieId);
  }

  Future<void> fetchMoviesStream() async {
    try {
      _userId = _userService.getCurrentUserId();
      if (_genre.isEmpty) {
        _movieStreamList = _movieRepository.fetchMoviesStream(_userId);
      } else {
        _movieStreamList =
            _movieRepository.fetchMoviesStreamByGenre(_genre, _userId);
      }
      notifyListeners();
    } catch (e) {
      print(e.toString());
    }
  }
}
