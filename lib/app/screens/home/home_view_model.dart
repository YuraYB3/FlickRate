import 'dart:developer';

import 'package:flickrate/app/screens/reviews/show_reviews/show_reviews_view_model.dart';
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
  late Stream<IMyUser> _userStream;
  HomeViewState _homeState = HomeViewState.loadingInfo;
  Stream<IMyUser> get userStream => _userStream;
  HomeViewState get homeState => _homeState;

  HomeViewModel({
    required IUserService userService,
    required INavigationUtil navigationUtil,
    required IMyUserRepository myUserRepository,
  })  : _navigationUtil = navigationUtil,
        _userService = userService,
        _myUserRepository = myUserRepository {
    _init();
  }

  void _init() {
    String userId = _userService.getCurrentUserId();
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
}
