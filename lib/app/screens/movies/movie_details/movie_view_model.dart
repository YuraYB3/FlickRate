import 'dart:developer';
import 'package:flickrate/app/routing/routes.dart';
import 'package:flickrate/domain/date_time/idate_time_service.dart';
import 'package:share_plus/share_plus.dart';

import 'package:flickrate/domain/navigation/inavigation_util.dart';
import 'package:flickrate/domain/review/ireview.dart';
import 'package:flickrate/domain/user/i_my_user.dart';
import 'package:flickrate/domain/user/i_my_user_repository.dart';
import 'package:flickrate/domain/user_service/iuser_service.dart';
import 'package:flickrate/domain/review/ireview_repository.dart';
import 'package:flutter/material.dart';

import '../../../../data/review/review.dart';
import '../../../../domain/movies/imovie.dart';
import '../../../../domain/movies/imovie_repository.dart';

enum MovieState { loading, readyToWork }

class MovieViewModel extends ChangeNotifier {
  final IMovieRepository _movieRepository;
  final INavigationUtil _navigationUtil;
  final IReviewRepository _reviewRepository;
  final IMyUserRepository _userRepository;
  final IDateTimeService _dateTimeService;

  final IUserService _userService;
  final String _movieId;

  double _movieRating = 0.1;
  double get movieRating => _movieRating;
  String _movieReview = '';
  String get movieReview => _movieReview;
  int _currentPageIndex = 0;
  int get currentPageIndex => _currentPageIndex;

  late IMovie _movie;
  IMovie get movie => _movie;
  late Stream<List<IReview>> _reviewStreamList;
  Stream<List<IReview>> get reviewStreamList => _reviewStreamList;

  final Map<String, IMyUser> _userMap = {};
  Map<String, IMyUser> get userMap => _userMap;

  MovieState _movieState = MovieState.loading;
  MovieState get movieState => _movieState;

  MovieViewModel(
      {required String movieId,
      required IMovieRepository movieRepository,
      required INavigationUtil navigationUtil,
      required IUserService userService,
      required IReviewRepository reviewRepository,
      required IDateTimeService dateTimeService,
      required IMyUserRepository userRepo})
      : _movieRepository = movieRepository,
        _navigationUtil = navigationUtil,
        _userService = userService,
        _reviewRepository = reviewRepository,
        _userRepository = userRepo,
        _dateTimeService = dateTimeService,
        _movieId = movieId;

  Future<void> init() async {
    await _fetchMovie();
    await _fetchReviewStream();
    await _fetchUsers();
    _updateMovieState(MovieState.readyToWork);
  }

  Future<void> _fetchMovie() async {
    try {
      _movie = await _movieRepository.getMovieById(_movieId);
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

  Future<void> _fetchUsers() async {
    try {
      final reviews =
          await _reviewRepository.fetchReviewsStreamByMovieId(_movieId).first;
      for (var review in reviews) {
        if (!_userMap.containsKey(review.userId)) {
          _userMap[review.userId] =
              await _userRepository.fetchCurrentUser(review.userId).first;
        }
      }
    } catch (e) {
      log(e.toString());
    }
  }

  void _updateMovieState(MovieState movieState) {
    _movieState = movieState;
    notifyListeners();
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

  void onCreateReviewClicked(
      {required Function(String message) showException,
      required Function(String message) showSuccess,
      required IMovie movie}) {
    if (_movieReview.trim().isNotEmpty) {
      try {
        String userId = _userService.getCurrentUserId();
        if (userId.isNotEmpty) {
          _reviewRepository
              .createReview(
            Review(
              userId: userId,
              movieId: _movieId,
              rating: _movieRating,
              reviewText: _movieReview,
              movieGenre: movie.movieGenre,
              movieName: movie.movieName,
              creationTime: DateTime.now(),
            ),
          )
              .then(
            (value) {
              _fetchUsers();
              notifyListeners();
              _navigationUtil.navigateBack();
            },
          );
          showSuccess('Review created');
          _restoreDefaultValues();
        } else {
          showException("You are not logged in!");
        }
      } catch (e) {
        log(e.toString());
        showException("Can't create review");
        _navigationUtil.navigateBack();
      }
    } else {
      showException("Please, fill all the fields");
    }
  }

  void _restoreDefaultValues() {
    _movieReview = '';
    _movieRating = 0.1;
    notifyListeners();
  }

  void updateCurrentPageIndex(int value) {
    _currentPageIndex = value;
    notifyListeners();
  }

  void shareMovie() {
    Share.share('Have you seen this movie? \n' '$urlMovies$_movieId');
  }

  String getTimeAgoSinceDate(DateTime date) {
    return _dateTimeService.getTimeAgoSinceDate(date);
  }
}
