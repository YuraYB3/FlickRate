import 'package:flickrate/locator.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../domain/movies/imovie_repository.dart';
import '../../routing/inavigation_util.dart';

import 'movie_view.dart';
import 'movie_view_model.dart';

class MovieFactory {
  static Widget build(String movieId) {
    return ChangeNotifierProvider(
      create: (context) => MovieViewModel(
          movieId: movieId,
          navigationUtil: context.read<INavigationUtil>(),
          movieRepository: locator<IMovieRepository>()),
      child: Consumer<MovieViewModel>(
        builder: (context, value, child) => MovieView(
          model: value,
        ),
      ),
    );
  }
}
