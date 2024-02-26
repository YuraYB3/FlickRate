import 'package:flickrate/app/routing/inavigation_util.dart';
import 'package:flickrate/domain/movies/imovie.dart';
import 'package:flickrate/domain/movies/imovie_repository.dart';
import 'package:flutter/material.dart';

class MovieViewModel extends ChangeNotifier {
  final IMovieRepository _movieRepository;
  final INavigationUtil _navigationUtil;

  MovieViewModel(
      {required INavigationUtil navigationUtil,
      required IMovieRepository movieRepository})
      : _movieRepository = movieRepository,
        _navigationUtil = navigationUtil;

  void onDeleteButtonPressed(IMovie movie) {
    _movieRepository.deleteMovie(movie);
    _navigationUtil.navigateBack();
  }
}
