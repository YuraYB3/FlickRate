
import 'dart:developer';

import 'package:flickrate/domain/user_service/iuser_service.dart';
import 'package:flickrate/domain/review/ireview.dart';
import 'package:flickrate/domain/review/ireview_repository.dart';
import 'package:flutter/material.dart';


class ShowReviewsViewModel extends ChangeNotifier {
  final IReviewRepository _reviewRepository;
  final IUserService _userService;
  late Stream<List<IReview>> _reviewStreamList;
  Stream<List<IReview>> get reviewStreamList => _reviewStreamList;

  ShowReviewsViewModel(
      {required IReviewRepository reviewRepository,
      required IUserService userService})
      : _reviewRepository = reviewRepository,
        _userService = userService {
    _fetchReviewsStream();
  }
  Future<void> _fetchReviewsStream() async {
    try {
      String userID = _userService.getCurrentUserId();
      _reviewStreamList = _reviewRepository.fetchReviewsStreamByUserId(userID);

      notifyListeners();
    } catch (e) {
      log(e.toString());
    }
  }
}
