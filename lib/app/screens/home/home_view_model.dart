import 'dart:developer';

import 'package:flickrate/app/screens/reviews/show_reviews/show_reviews_view_model.dart';
import 'package:flickrate/domain/movies/imovie.dart';
import 'package:flickrate/domain/movies/imovie_repository.dart';
import 'package:flickrate/domain/user_service/iuser_service.dart';
import 'package:flutter/material.dart';

import '../../../domain/user/i_my_user.dart';
import '../../../domain/user/i_my_user_repository.dart';
import '../../../domain/navigation/inavigation_util.dart';
import '../../routing/routes.dart';

enum HomeViewState { readyToWork, loadingInfo }

class HomeViewModel extends ChangeNotifier {
  final INavigationUtil _navigationUtil;
  final IUserService _userService;
  final IMyUserRepository _myUserRepository;
  final IMovieRepository _movieRepository;
  late Stream<IMyUser> _userStream;
  late IMovie _randomMovie;
  IMovie get randomMovie => _randomMovie;
  HomeViewState _homeState = HomeViewState.loadingInfo;
  Stream<IMyUser> get userStream => _userStream;
  HomeViewState get homeState => _homeState;

  HomeViewModel(
      {required IUserService userService,
      required INavigationUtil navigationUtil,
      required IMyUserRepository myUserRepository,
      required IMovieRepository movieRepository})
      : _navigationUtil = navigationUtil,
        _userService = userService,
        _myUserRepository = myUserRepository,
        _movieRepository = movieRepository {
    _init();
  }

  void _init() {
    String userId = _userService.getCurrentUserId();
    _getDailyMovie();
    _fetchUserStream(userId);
  }

  void _fetchUserStream(String userId) async {
    try {
      _userStream = _myUserRepository.fetchCurrentUser(userId);
      _homeState = HomeViewState.readyToWork;
      notifyListeners();
    } catch (e) {
      log(e.toString());
      _homeState = HomeViewState.loadingInfo;
      notifyListeners();
    }
  }

  void onShowAllClicked() {
    _navigationUtil.navigateTo(
      routeShowReviews,
      data: {'reviewLoadingType': ReviewLoadingType.byUserId},
    );
  }

  void onGenreTileClicked(String genreName) {
    _navigationUtil.navigateTo(
      routeShowReviews,
      data: {
        'loadingType': ReviewLoadingType.byMovieGenre,
        'movieGenre': genreName
      },
    );
  }

  void _getDailyMovie() async {
    _randomMovie = await _movieRepository.getDailyMovie();
  }

  void onMovieClicked() async {
    log(_randomMovie.documentId);
    await _navigationUtil.navigateTo(routeMovie, data: _randomMovie.documentId);
  }
}
