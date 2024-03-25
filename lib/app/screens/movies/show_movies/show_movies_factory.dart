import 'package:flickrate/app/services/user/iuser_service.dart';
import 'package:flickrate/locator.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../domain/movies/imovie_repository.dart';
import '../../../routing/inavigation_util.dart';
import 'show_movies_view.dart';
import 'show_movies_view_model.dart';

class ShowMoviesFactory {
  static Widget build(String genre) {
    return ChangeNotifierProvider(
        create: (context) => ShowMoviesViewModel(
            userService: locator<IUserService>(),
            movieRepository: locator<IMovieRepository>(),
            navigationUtil: context.read<INavigationUtil>(),
            genre: genre),
        child: Consumer<ShowMoviesViewModel>(
          builder: (context, model, child) => ShowMoviesView(model: model),
        ));
  }
}