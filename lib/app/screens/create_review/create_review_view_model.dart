// ignore_for_file: avoid_print

import 'package:flickrate/app/services/user/iuser_service.dart';
import 'package:flickrate/data/review/review.dart';
import 'package:flickrate/domain/review/ireview_repository.dart';
import 'package:flutter/material.dart';
import '../../routing/inavigation_util.dart';
import '../../../utils/input_validator.dart';

class CreateReviewViewModel extends ChangeNotifier {
  final INavigationUtil _navigationUtil;
  final IReviewRepository _reviewRepository;
  final IUserService _userService;
  final InputValidator _inputValidator = InputValidator();
  String _movieName = '';
  String _reviewText = '';
  late String _userId;

  String get movieName => _movieName;
  String get movieDescription => _reviewText;

  CreateReviewViewModel(
      {required IReviewRepository reviewRepository,
      required IUserService userService,
      required INavigationUtil navigationUtil})
      : _navigationUtil = navigationUtil,
        _userService = userService,
        _reviewRepository = reviewRepository;

  void onCreateReviewClicked(
      {required Function(String message) showError,
      required Function(String message) showSuccess}) {
    if (isFieldsValid()) {
      try {
        _userId = _userService.getCurrentUserId();
        _reviewRepository.createReview(Review(
          userId: _userId,
          movieId: 'GFWqjPxplsjOsdWOGIDM',
          rating: 5,
          reviewText: _reviewText,
        ));
        showSuccess('Review created');
        _navigationUtil.navigateBack();
      } catch (e) {
        print(e.toString());
        showError("Can't create review");
        _navigationUtil.navigateBack();
      }
    } else {
      showError("Please, fill all the fields");
    }
  }

  void updateMovieName(String value) {
    _movieName = value;
    notifyListeners();
  }

  void updateMovieDescription(String value) {
    _reviewText = value;
    notifyListeners();
  }

  bool isFieldsValid() {
    return _inputValidator.isCreateMovieFormValidate(_movieName, _reviewText);
  }
}
