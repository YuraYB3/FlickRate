import 'package:flickrate/domain/movies/imovie_repository.dart';
import 'package:flickrate/domain/user_service/iuser_service.dart';
import 'package:flickrate/domain/user/i_my_user_repository.dart';
import 'package:flickrate/locator.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../domain/navigation/inavigation_util.dart';
import 'home_screen.dart';
import 'home_view_model.dart';

class HomeFactory {
  static Widget build() {
    return ChangeNotifierProvider(
      create: (context) => HomeViewModel(
          movieRepository: locator<IMovieRepository>(),
          userService: locator<IUserService>(),
          navigationUtil: locator<INavigationUtil>(),
          myUserRepository: locator<IMyUserRepository>()),
      child: Consumer<HomeViewModel>(
        builder: (context, model, child) => HomeScreen(model: model),
      ),
    );
  }
}
