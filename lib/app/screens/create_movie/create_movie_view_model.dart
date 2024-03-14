// ignore_for_file: avoid_print

import 'package:flickrate/app/services/user/iuser_service.dart';
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
  String _movieGenre = 'Action';
  String _movieDescription = '';
  late String _userId;

  String get movieName => _movieName;
  String get movieGenre => _movieGenre;
  String get movieDescription => _movieDescription;

  CreateMovieViewModel(
      {required IMovieRepository movieRepository,
      required IUserService userService,
      required INavigationUtil navigationUtil})
      : _navigationUtil = navigationUtil,
        _userService = userService,
        _movieRepository = movieRepository;

  void onCreateMovieClicked({required Function(String message) showException}) {
    if (isFieldsValid()) {
      try {
        _userId = _userService.getCurrentUserId();
        _movieRepository.createMovie(Movie(
          userId: _userId,
          name: _movieName,
          genre: _movieGenre,
          description: _movieDescription,
        ));
        _navigationUtil.navigateBack();
      } catch (e) {
        print(e.toString());
        showException("Can't create mew movie");
        _navigationUtil.navigateBack();
      }
    }
    showException("Please, fill all the fields");
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
