import 'package:flickrate/app/routing/inavigation_util.dart';
import 'package:flickrate/app/services/network/inetwork_service.dart';
import 'package:flickrate/data/movies/movie_repository.dart';
import 'package:flickrate/domain/movies/imovie.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'movie_view.dart';
import 'movie_view_model.dart';

class MovieFactory {
  static Widget build(IMovie movie) {
    return ChangeNotifierProvider(
      create: (context) => MovieViewModel(
          navigationUtil: context.read<INavigationUtil>(),
          movieRepository:
              MovieRepository(networkService: context.read<INetworkService>())),
      child: Consumer<MovieViewModel>(
        builder: (context, value, child) =>
            MovieView(movie: movie, model: value),
      ),
    );
  }
}
