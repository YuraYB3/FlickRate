import 'package:flickrate/app/routing/inavigation_util.dart';
import 'package:flickrate/data/movie.dart';
import 'package:flutter/material.dart';

class AddMovieViewModel extends ChangeNotifier {
  final INavigationUtil _navigationUtil;
  final MovieRepository _movieRepository;
  AddMovieViewModel(
      {required MovieRepository movieRepository,
      required INavigationUtil navigationUtil})
      : _navigationUtil = navigationUtil,
        _movieRepository = movieRepository;

  void addMovie(String name, String genre, String description) {
    _movieRepository.addMovie(
        MovieModel(name: name, genre: genre, description: description));
    _navigationUtil.navigateBack();
  }
}
