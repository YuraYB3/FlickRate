import 'dart:developer';

import 'package:flickrate/domain/navigation/inavigation_util.dart';
import 'package:flickrate/domain/user_service/iuser_service.dart';
import 'package:flickrate/domain/review/ireview.dart';
import 'package:flickrate/domain/review/ireview_repository.dart';
import 'package:flutter/material.dart';

enum ReviewLoadingType { byUserId, byMovieGenre }

class ShowReviewsViewModel extends ChangeNotifier {
  final IReviewRepository _reviewRepository;
  final IUserService _userService;
  final INavigationUtil _navigationUtil;

  final ReviewLoadingType _reviewLoadingType;
  final String? _movieGenre;
  late Stream<List<IReview>> _reviewStreamList;
  Stream<List<IReview>> get reviewStreamList => _reviewStreamList;

  ShowReviewsViewModel(
      {required IReviewRepository reviewRepository,
      required IUserService userService,
      required ReviewLoadingType reviewLoadingType,
      String? movieGenre,
      required INavigationUtil navigation})
      : _reviewRepository = reviewRepository,
        _userService = userService,
        _reviewLoadingType = reviewLoadingType,
        _navigationUtil = navigation,
        _movieGenre = movieGenre;

  void init() {
    switch (_reviewLoadingType) {
      case ReviewLoadingType.byUserId:
        _fetchReviewsStreamByUserId();
        break;
      case ReviewLoadingType.byMovieGenre:
        _fetchReviewsStreamByUserMovieGenre();
      default:
    }
  }

  Future<void> _fetchReviewsStreamByUserId() async {
    log('message');
    try {
      String userID = _userService.getCurrentUserId();
      _reviewStreamList = _reviewRepository.fetchReviewsStreamByUserId(userID);
    } catch (e) {
      log(e.toString());
    }
  }

  Future<void> _fetchReviewsStreamByUserMovieGenre() async {
    log('message 2');

    try {
      String userID = _userService.getCurrentUserId();
      _reviewStreamList = _reviewRepository
          .fetchReviewsStreamByUserIdAndMovieGenre(_movieGenre!, userID);
    } catch (e) {
      log(e.toString());
    }
  }

  Future<void> deleteReview(String reviewId) async {
    try {
      await _reviewRepository.deleteReview(reviewId);
    } catch (e) {
      log(e.toString());
    }
  }

  void navigateBack() {
    _navigationUtil.navigateBack();
  }
}
