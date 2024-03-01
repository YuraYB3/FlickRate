import 'package:flutter/material.dart';

import '../../../domain/movies/imovie.dart';
import '../../../domain/movies/imovie_repository.dart';
import '../../routing/inavigation_util.dart';
import '../../services/functions/ifunction_service.dart';

class MovieViewModel extends ChangeNotifier {
  final IMovieRepository _movieRepository;
  final INavigationUtil _navigationUtil;
  final IFunctionService _functionService;
  final String _movieId;
  late Stream<IMovie> _movieStream;
  Stream<IMovie> get movieStream => _movieStream;

  MovieViewModel(
      {required INavigationUtil navigationUtil,
      required String movieId,
      required IFunctionService functionService,
      required IMovieRepository movieRepository})
      : _movieRepository = movieRepository,
        _functionService = functionService,
        _movieId = movieId,
        _navigationUtil = navigationUtil {
    fetchMovieStream();
  }

  void onDeleteButtonPressed(String id) {
    _movieRepository.deleteMovie(id);
    _navigationUtil.navigateBack();
  }

  void onIncreaseButtonClicked(String id) {
    _functionService.increaseRating(id);
  }

  void onDecreaseButtonClicked(String id) {
    _functionService.decreaseRating(id);
  }

  Future<void> fetchMovieStream() async {
    _movieStream = _movieRepository.fetchMovie(_movieId);
  }
}
