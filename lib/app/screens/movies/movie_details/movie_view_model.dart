// ignore_for_file: avoid_print

import 'package:flickrate/app/routing/inavigation_util.dart';
import 'package:flickrate/app/services/user/iuser_service.dart';
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
  int currentPageIndex = 0;

  final PageController _pageController = PageController();
  PageController get pageController => _pageController;
  late Stream<List<IReview>> _reviewStreamList;
  Stream<List<IReview>> get reviewStreamList => _reviewStreamList;
  late Stream<IMovie> _movieStream;
  Stream<IMovie> get movieStream => _movieStream;
  bool _isShowCreateReviewFormClicked = false;
  bool get isShowCreateReviewFormClicked => _isShowCreateReviewFormClicked;

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
      print(e.toString());
    }
  }

  Future<void> _fetchReviewStream() async {
    try {
      _reviewStreamList =
          _reviewRepository.fetchReviewsStreamByMovieId(_movieId);
    } catch (e) {
      print(e.toString());
    }
  }

  void onBackButtonClicked() {
    _navigationUtil.navigateBack();
  }

  void moveToPreviousPage() {
    currentPageIndex--;
  }

  void moveToNextPage() {
    currentPageIndex++;
  }

  void setCurrentPageIndex(int index) {
    currentPageIndex = index;
    notifyListeners();
  }

  void onShowCreateReviewFormClicked() {
    _isShowCreateReviewFormClicked = !_isShowCreateReviewFormClicked;
    notifyListeners();
  }

  void updateMovieRatingField(double value) {
    _movieRating = value;
    notifyListeners();
  }

  void updateMovieReviewField(String value) {
    _movieReview = value;
    notifyListeners();
  }

  void onCreateReviewClicked(
      {required Function(String message) showError,
      required Function(String message) showSuccess}) {
    if (_movieReview.trim().isNotEmpty) {
      try {
        String userId = _userService.getCurrentUserId();
        _reviewRepository.createReview(Review(
          userId: userId,
          movieId: _movieId,
          rating: _movieRating,
          reviewText: _movieReview,
        ));
        showSuccess('Review created');
        _restoreDefaultValues();
        notifyListeners();
      } catch (e) {
        print(e.toString());
        showError("Can't create review");
        _navigationUtil.navigateBack();
      }
    } else {
      showError("Please, fill all the fields");
    }
  }

  void _restoreDefaultValues() {
    _isShowCreateReviewFormClicked = false;
    currentPageIndex = 0;
    _movieReview = '';
    _movieRating = 0.1;
  }
}
