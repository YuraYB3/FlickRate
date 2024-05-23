import 'dart:developer';

import 'package:flickrate/app/screens/reviews/show_reviews_view_model.dart';
import 'package:flickrate/domain/date_time/idate_time_service.dart';
import 'package:flickrate/domain/movies/imovie.dart';
import 'package:flickrate/domain/movies/imovie_repository.dart';
import 'package:flickrate/domain/user_service/iuser_service.dart';
import 'package:flutter/material.dart';

import '../../../domain/user/i_my_user.dart';
import '../../../domain/user/i_my_user_repository.dart';
import '../../../domain/navigation/inavigation_util.dart';
import '../../routing/routes.dart';

enum HomeViewState { readyToWork, loadingInfo, error }

class HomeViewModel extends ChangeNotifier {
  final INavigationUtil _navigationUtil;
  final IUserService _userService;
  final IMyUserRepository _myUserRepository;
  final IMovieRepository _movieRepository;
  final IDateTimeService _dateTimeService;
  late Stream<IMyUser> _userStream;
  late Stream<IMovie> _randomMovieStream;
  Stream<IMovie> get randomMovieStream => _randomMovieStream;
  HomeViewState _homeState = HomeViewState.loadingInfo;
  Stream<IMyUser> get userStream => _userStream;
  HomeViewState get homeState => _homeState;

  HomeViewModel(
      {required IUserService userService,
      required INavigationUtil navigationUtil,
      required IMyUserRepository myUserRepository,
      required IMovieRepository movieRepository,
      required IDateTimeService dateTimeService})
      : _navigationUtil = navigationUtil,
        _userService = userService,
        _myUserRepository = myUserRepository,
        _movieRepository = movieRepository,
        _dateTimeService = dateTimeService {
    _init();
  }

  void _init() async {
    String userId = _userService.getCurrentUserId();
    await _fetchDailyMovie();
    await _fetchUserStream(userId);
  }

  Future<void> _fetchUserStream(String userId) async {
    try {
      _userStream = _myUserRepository.fetchCurrentUser(userId);
      _homeState = HomeViewState.readyToWork;
      _changeHomeViewState(HomeViewState.readyToWork);
    } catch (e) {
      log(e.toString());
      _changeHomeViewState(HomeViewState.error);
      notifyListeners();
    }
  }

  Future<void> _fetchDailyMovie() async {
    _randomMovieStream = _movieRepository.getDailyMovie();
  }

  void onShowAllClicked() {
    _navigationUtil.navigateTo(
      routeShowReviews,
      data: {'reviewLoadingType': ReviewLoadingType.byUserId},
    );
  }

  void onMovieClicked(String movieId) async {
    log(movieId);
    await _navigationUtil.navigateTo(routeMovie, data: movieId);
  }

  void _changeHomeViewState(HomeViewState state) {
    _homeState = state;
    notifyListeners();
  }

  String getTimeAgoSinceDate(DateTime date) {
    return _dateTimeService.getTimeAgoSinceDate(date);
  }
}
