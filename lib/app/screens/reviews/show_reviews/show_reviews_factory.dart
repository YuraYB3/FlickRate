import 'package:flickrate/app/routing/inavigation_util.dart';
import 'package:flickrate/app/services/user/iuser_service.dart';
import 'package:flickrate/domain/review/ireview_repository.dart';
import 'package:flickrate/locator.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'show_reviews_view.dart';
import 'show_reviews_view_model.dart';

class ShowReviewsFactory {
  static Widget build() {
    return ChangeNotifierProvider(
      create: (context) => ShowReviewsViewModel(
          navigationUtil: context.read<INavigationUtil>(),
          reviewRepository: locator<IReviewRepository>(),
          userService: locator<IUserService>()),
      child: Consumer<ShowReviewsViewModel>(
        builder: (context, model, child) => ShowReviewsView(model: model),
      ),
    );
  }
}
