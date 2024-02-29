import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../data/movies/movie_repository.dart';
import '../../routing/inavigation_util.dart';
import '../../services/network/inetwork_service.dart';
import 'show_all_movies_view.dart';
import 'show_all_movies_view_model.dart';

class ShowAllMoviesFactory {
  static Widget build() {
    return ChangeNotifierProvider(
        create: (context) => ShowAllMoviesViewModel(
            movieRepository: MovieRepository(
                networkService: context.read<INetworkService>()),
            navigationUtil: context.read<INavigationUtil>()),
        child: Consumer<ShowAllMoviesViewModel>(
          builder: (context, model, child) => ShowAllMoviesView(model: model),
        ));
  }
}
