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
        movieRepository: locator<IMovieRepository>(),
        navigationUtil: context.read<INavigationUtil>(),
      ),
      child: Consumer<ShowMoviesViewModel>(
        builder: (context, model, child) => ShowMoviesView(model: model),
      ),
    );
  }
}
