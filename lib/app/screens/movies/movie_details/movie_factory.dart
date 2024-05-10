import 'package:flickrate/app/routing/inavigation_util.dart';
import 'package:flickrate/app/services/user/iuser_service.dart';
import 'package:flickrate/domain/review/ireview_repository.dart';
import 'package:flickrate/locator.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../domain/movies/imovie_repository.dart';

import 'movie_screen.dart';
import 'movie_view_model.dart';

class MovieFactory {
  static Widget build(String movieId) {
    return ChangeNotifierProvider(
      create: (context) => MovieViewModel(
          reviewRepository: locator<IReviewRepository>(),
          userService: locator<IUserService>(),
          navigationUtil: locator<INavigationUtil>(),
          movieId: movieId,
          movieRepository: locator<IMovieRepository>()),
      child: Consumer<MovieViewModel>(
        builder: (context, value, child) => MovieScreen(
          model: value,
        ),
      ),
    );
  }
}
