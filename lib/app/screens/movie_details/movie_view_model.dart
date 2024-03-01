import 'package:flutter/material.dart';

import '../../../domain/movies/imovie.dart';
import '../../../domain/movies/imovie_repository.dart';
import '../../routing/inavigation_util.dart';

class MovieViewModel extends ChangeNotifier {
  final IMovieRepository _movieRepository;
  final INavigationUtil _navigationUtil;

  final String _movieId;
  late Stream<IMovie> _movieStream;
  Stream<IMovie> get movieStream => _movieStream;

  MovieViewModel(
      {required INavigationUtil navigationUtil,
      required String movieId,
      required IMovieRepository movieRepository})
      : _movieRepository = movieRepository,
        _movieId = movieId,
        _navigationUtil = navigationUtil {
    fetchMovieStream();
  }

  void onDeleteButtonPressed(String id) {
    _movieRepository.deleteMovie(id);
    _navigationUtil.navigateBack();
  }

  void onIncreaseButtonClicked(String id) {
    _movieRepository.increaseRating(id);
  }

  void onDecreaseButtonClicked(String id) {
    _movieRepository.decreaseRating(id);
  }

  Future<void> fetchMovieStream() async {
    _movieStream = _movieRepository.fetchMovie(_movieId);
  }
}
