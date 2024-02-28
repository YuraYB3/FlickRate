import 'package:flickrate/app/routing/inavigation_util.dart';
import 'package:flickrate/app/services/network/inetwork_service.dart';
import 'package:flickrate/data/movies/movie_repository.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

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
