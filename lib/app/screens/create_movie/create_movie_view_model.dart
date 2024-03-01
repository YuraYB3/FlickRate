import 'package:flutter/material.dart';

import '../../../data/movies/movie.dart';
import '../../../data/movies/movie_repository.dart';
import '../../routing/inavigation_util.dart';
import '../../services/input/input_validator.dart';

class CreateMovieViewModel extends ChangeNotifier {
  final INavigationUtil _navigationUtil;
  final MovieRepository _movieRepository;
  final InputValidator _inputValidator = InputValidator();
  String _movieName = '';
  String _movieGenre = 'Action';
  String _movieDescription = '';

  String get movieName => _movieName;
  String get movieGenre => _movieGenre;
  String get movieDescription => _movieDescription;

  CreateMovieViewModel(
      {required MovieRepository movieRepository,
      required INavigationUtil navigationUtil})
      : _navigationUtil = navigationUtil,
        _movieRepository = movieRepository;

  void onCreateMovieClicked() {
    _movieRepository.createMovie(Movie(
      name: _movieName,
      genre: _movieGenre,
      description: _movieDescription,
    ));
    _navigationUtil.navigateBack();
  }

  void updateMovieName(String value) {
    _movieName = value;
    notifyListeners();
  }

  void updateMovieGenre(String value) {
    _movieGenre = value;
    notifyListeners();
  }

  void updateMovieDescription(String value) {
    _movieDescription = value;
    notifyListeners();
  }

  bool isFieldsValid() {
    return _inputValidator.isCreateMovieFormValidate(
        _movieName, _movieGenre, _movieDescription);
  }
}