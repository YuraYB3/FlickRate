import 'dart:developer';

import 'package:flickrate/domain/navigation/inavigation_util.dart';
import 'package:flickrate/domain/user_service/iuser_service.dart';
import 'package:flickrate/domain/review/ireview_repository.dart';
import 'package:flutter/material.dart';

import '../../../../data/review/review.dart';
import '../../../../domain/movies/imovie.dart';
import '../../../../domain/movies/imovie_repository.dart';
import '../../../../domain/review/ireview.dart';

class MovieViewModel extends ChangeNotifier {
  final IMovieRepository _movieRepository;
  final INavigationUtil _navigationUtil;
  final IReviewRepository _reviewRepository;
  final IUserService _userService;
  final String _movieId;

  double _movieRating = 0.1;
  double get movieRating => _movieRating;
  String _movieReview = '';
  String get movieReview => _movieReview;
  int _currentPageIndex = 0;
  int get currentPageIndex => _currentPageIndex;

  late Stream<List<IReview>> _reviewStreamList;
  Stream<List<IReview>> get reviewStreamList => _reviewStreamList;
  late Stream<IMovie> _movieStream;
  Stream<IMovie> get movieStream => _movieStream;

  MovieViewModel(
      {required String movieId,
      required IMovieRepository movieRepository,
      required INavigationUtil navigationUtil,
      required IUserService userService,
      required IReviewRepository reviewRepository})
      : _movieRepository = movieRepository,
        _navigationUtil = navigationUtil,
        _userService = userService,
        _reviewRepository = reviewRepository,
        _movieId = movieId {
    _init();
  }

  Future<void> _init() async {
    await _fetchMovieStream();
    await _fetchReviewStream();
  }

  Future<void> _fetchMovieStream() async {
    try {
      _movieStream = _movieRepository.fetchMovie(_movieId);
      _reviewStreamList =
          _reviewRepository.fetchReviewsStreamByMovieId(_movieId);
    } catch (e) {
      log(e.toString());
    }
  }

  Future<void> _fetchReviewStream() async {
    try {
      _reviewStreamList =
          _reviewRepository.fetchReviewsStreamByMovieId(_movieId);
    } catch (e) {
      log(e.toString());
    }
  }

  void onBackButtonClicked() {
    _restoreDefaultValues();
    _navigationUtil.navigateBack();
  }

  void updateMovieRatingField(double value) {
    _movieRating = value;
    notifyListeners();
  }

  void updateMovieReviewField(String value) {
    _movieReview = value;
    notifyListeners();
  }

  void onCreateReviewClicked(Function(String message) showError,
      Function(String message) showSuccess) {
    if (_movieReview.trim().isNotEmpty) {
      try {
        String userId = _userService.getCurrentUserId();
        if (userId.isNotEmpty) {
          _reviewRepository.createReview(
            Review(
              userId: userId,
              movieId: _movieId,
              rating: _movieRating,
              reviewText: _movieReview,
            ),
          );
          showSuccess('Review created');
          _restoreDefaultValues();
          notifyListeners();
        } else {
          showError("You are not logged in!");
        }
      } catch (e) {
        log(e.toString());
        showError("Can't create review");
        _navigationUtil.navigateBack();
      }
    } else {
      showError("Please, fill all the fields");
    }
  }

  void _restoreDefaultValues() {
    _movieReview = '';
    _movieRating = 0.1;
  }

  void updateCurrentPageIndex(int value) {
    _currentPageIndex = value;
    notifyListeners();
  }
}
