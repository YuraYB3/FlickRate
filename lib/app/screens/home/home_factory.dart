import 'package:flickrate/app/routing/inavigation_util.dart';
import 'package:flickrate/app/services/network/inetwork_service.dart';
import 'package:flickrate/data/movies/movie_repository.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'home_view.dart';
import 'home_view_model.dart';

class HomeFactory {
  static Widget build() {
    return ChangeNotifierProvider(
      create: (context) => HomeViewModel(
        movieRepository:
            MovieRepository(networkService: context.read<INetworkService>()),
        navigationUtil: context.read<INavigationUtil>(),
      ),
      child: Consumer<HomeViewModel>(
        builder: (context, model, child) => HomeView(model: model),
      ),
    );
  }
}
