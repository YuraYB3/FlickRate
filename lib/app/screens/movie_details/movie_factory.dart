import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../data/movies/movie_repository.dart';
import '../../routing/inavigation_util.dart';
import '../../services/functions/ifunction_service.dart';
import '../../services/network/inetwork_service.dart';
import 'movie_view.dart';
import 'movie_view_model.dart';

class MovieFactory {
  static Widget build(String movieId) {
    return ChangeNotifierProvider(
      create: (context) => MovieViewModel(
          movieId: movieId,
          navigationUtil: context.read<INavigationUtil>(),
          movieRepository: MovieRepository(
            networkService: context.read<INetworkService>(),
            functionService: context.read<IFunctionService>(),
          )),
      child: Consumer<MovieViewModel>(
        builder: (context, value, child) => MovieView(model: value),
      ),
    );
  }
}
