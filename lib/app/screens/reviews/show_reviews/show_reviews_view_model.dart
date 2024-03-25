// ignore_for_file: avoid_print

import 'package:flickrate/app/services/user/iuser_service.dart';
import 'package:flickrate/domain/review/ireview.dart';
import 'package:flickrate/domain/review/ireview_repository.dart';
import 'package:flutter/material.dart';

import '../../../routing/inavigation_util.dart';
import '../../../routing/routes.dart';

class ShowReviewsViewModel extends ChangeNotifier {
  final INavigationUtil _navigationUtil;
  final IReviewRepository _reviewRepository;
  final IUserService _userService;
  late Stream<List<IReview>> _reviewStreamList;
  Stream<List<IReview>> get movieStreamList => _reviewStreamList;

  ShowReviewsViewModel(
      {required INavigationUtil navigationUtil,
      required IReviewRepository reviewRepository,
      required IUserService userService})
      : _navigationUtil = navigationUtil,
        _reviewRepository = reviewRepository,
        _userService = userService {
    _fetchReviewsStream();
  }

  void onListTileClicked(String movieId) async {
    await _navigationUtil.navigateTo(routeMovie, data: movieId);
  }

  Future<void> _fetchReviewsStream() async {
    try {
      String userID = _userService.getCurrentUserId();
      _reviewStreamList = _reviewRepository.fetchReviewsStreamByUserId(userID);
      notifyListeners();
    } catch (e) {
      print(e.toString());
    }
  }
}
