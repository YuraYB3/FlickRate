import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../domain/movies/imovie_repository.dart';
import '../../../locator.dart';
import '../../routing/inavigation_util.dart';

import 'create_movie_view.dart';
import 'create_movie_view_model.dart';

class CreateMovieFactory {
  static Widget build() {
    return ChangeNotifierProvider(
        create: (context) => CreateMovieViewModel(
              movieRepository: locator<IMovieRepository>(),
              navigationUtil: context.read<INavigationUtil>(),
            ),
        child: Consumer<CreateMovieViewModel>(
          builder: (context, model, child) => CreateMovieView(model: model),
        ));
  }
}
