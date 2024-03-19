// ignore_for_file: avoid_print

import 'package:flickrate/app/services/user/iuser_service.dart';
import 'package:flickrate/data/genre/movie_genre.dart';
import 'package:flutter/material.dart';

import '../../../data/movies/movie.dart';
import '../../../domain/movies/imovie_repository.dart';
import '../../routing/inavigation_util.dart';
import '../../../utils/input_validator.dart';

class CreateMovieViewModel extends ChangeNotifier {
  final INavigationUtil _navigationUtil;
  final IMovieRepository _movieRepository;
  final IUserService _userService;
  final InputValidator _inputValidator = InputValidator();
  String _movieName = '';
  MovieGenre _movieGenre = MovieGenre.Action;
  String _movieDescription = '';
  late String _userId;

  String get movieName => _movieName;
  MovieGenre get movieGenre => _movieGenre;
  String get movieDescription => _movieDescription;

  CreateMovieViewModel(
      {required IMovieRepository movieRepository,
      required IUserService userService,
      required INavigationUtil navigationUtil})
      : _navigationUtil = navigationUtil,
        _userService = userService,
        _movieRepository = movieRepository;

  void onCreateMovieClicked(
      {required Function(String message) showError,
      required Function(String message) showSuccess}) {
    if (isFieldsValid()) {
      try {
        _userId = _userService.getCurrentUserId();
        _movieRepository.createMovie(Movie(
          userId: _userId,
          name: _movieName,
          genre: _movieGenre.name,
          description: _movieDescription,
        ));
        showSuccess('Movie created');
        _navigationUtil.navigateBack();
      } catch (e) {
        print(e.toString());
        showError("Can't create mew movie");
        _navigationUtil.navigateBack();
      }
    } else {
      showError("Please, fill all the fields");
    }
  }

  void updateMovieName(String value) {
    _movieName = value;
    notifyListeners();
  }

  void updateMovieGenre(MovieGenre value) {
    _movieGenre = value;
    notifyListeners();
  }

  void updateMovieDescription(String value) {
    _movieDescription = value;
    notifyListeners();
  }

  bool isFieldsValid() {
    return _inputValidator.isCreateMovieFormValidate(
        _movieName, _movieGenre.name, _movieDescription);
  }
}
