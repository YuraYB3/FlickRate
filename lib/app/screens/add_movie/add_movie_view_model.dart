import 'package:flickrate/app/routing/inavigation_util.dart';
import 'package:flickrate/data/movies/movie.dart';
import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';

import '../../../data/movies/movie_repository.dart';

class AddMovieViewModel extends ChangeNotifier {
  final INavigationUtil _navigationUtil;
  final MovieRepository _movieRepository;
  AddMovieViewModel(
      {required MovieRepository movieRepository,
      required INavigationUtil navigationUtil})
      : _navigationUtil = navigationUtil,
        _movieRepository = movieRepository;

  void addMovie(String name, String genre, String description) {
    String movieId = const Uuid().v4();
    _movieRepository.createMovie(
        Movie(id: movieId, name: name, genre: genre, description: description));
    _navigationUtil.navigateBack();
  }
}
