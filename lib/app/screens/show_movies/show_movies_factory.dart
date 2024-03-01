import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../data/movies/movie_repository.dart';
import '../../routing/inavigation_util.dart';
import '../../services/network/inetwork_service.dart';
import 'show_movies_view.dart';
import 'show_movies_view_model.dart';

class ShowMoviesFactory {
  static Widget build(String genre) {
    return ChangeNotifierProvider(
        create: (context) => ShowMoviesViewModel(
            movieRepository: MovieRepository(
                networkService: context.read<INetworkService>()),
            navigationUtil: context.read<INavigationUtil>(),
            genre: genre),
        child: Consumer<ShowMoviesViewModel>(
          builder: (context, model, child) => ShowMoviesView(model: model),
        ));
  }
}
