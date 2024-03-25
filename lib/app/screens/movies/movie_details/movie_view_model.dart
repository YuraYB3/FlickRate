// ignore_for_file: avoid_print

import 'package:flickrate/app/routing/inavigation_util.dart';
import 'package:flutter/material.dart';

import '../../../../domain/movies/imovie.dart';
import '../../../../domain/movies/imovie_repository.dart';

class MovieViewModel extends ChangeNotifier {
  final IMovieRepository _movieRepository;
  final INavigationUtil _navigationUtil;

  final String _movieId;
  late Stream<IMovie> _movieStream;
  Stream<IMovie> get movieStream => _movieStream;

  MovieViewModel(
      {required String movieId,
      required IMovieRepository movieRepository,
      required INavigationUtil navigationUtil})
      : _movieRepository = movieRepository,
        _navigationUtil = navigationUtil,
        _movieId = movieId {
    _fetchMovieStream();
  }

/*  void onDeleteButtonPressed(
      {required Function(String message) showException,
      required String movieId}) {
    try {
      _movieRepository.deleteMovie(movieId);
      _navigationUtil.navigateBack();
    } catch (e) {
      print(e.toString());
      showException("Can't delete movie");
    }
  }*/

  /* void onIncreaseButtonClicked(
      {required Function(String message) showException,
      required String movieId}) {
    try {
      _movieRepository.increaseRating(movieId);
    } catch (e) {
      print(e.toString());
      showException("Can't increase rating");
    }
  }
*/
  /* void onDecreaseButtonClicked(
      {required Function(String message) showException,
      required String movieId}) {
    try {
      _movieRepository.decreaseRating(movieId);
    } catch (e) {
      print(e.toString());
      showException("Can't decrease rating");
    }
  }
*/
  Future<void> _fetchMovieStream() async {
    try {
      _movieStream = _movieRepository.fetchMovie(_movieId);
    } catch (e) {
      print(e.toString());
    }
  }

  void onBackButtonClicked() {
    _navigationUtil.navigateBack();
  }
}
