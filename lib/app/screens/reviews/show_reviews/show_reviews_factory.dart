import 'package:flickrate/domain/user_service/iuser_service.dart';
import 'package:flickrate/domain/review/ireview_repository.dart';
import 'package:flickrate/locator.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'show_reviews_screen.dart';
import 'show_reviews_view_model.dart';

class ShowReviewsFactory {
  static Widget build() {
    return ChangeNotifierProvider(
      create: (context) => ShowReviewsViewModel(
          reviewRepository: locator<IReviewRepository>(),
          userService: locator<IUserService>()),
      child: Consumer<ShowReviewsViewModel>(
        builder: (context, model, child) => ShowReviewsScreen(model: model),
      ),
    );
  }
}
