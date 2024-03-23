import 'package:flickrate/app/services/user/iuser_service.dart';
import 'package:flickrate/domain/review/ireview_repository.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../locator.dart';
import '../../routing/inavigation_util.dart';
import 'create_review_view.dart';
import 'create_review_view_model.dart';

class CreateReviewFactory {
  static Widget build() {
    return ChangeNotifierProvider(
      create: (context) => CreateReviewViewModel(
        userService: locator<IUserService>(),
        reviewRepository: locator<IReviewRepository>(),
        navigationUtil: context.read<INavigationUtil>(),
      ),
      child: Consumer<CreateReviewViewModel>(
        builder: (context, model, child) => CreateReviewView(model: model),
      ),
    );
  }
}
