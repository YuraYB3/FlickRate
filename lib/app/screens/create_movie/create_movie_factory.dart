import 'package:flickrate/app/screens/create_movie/create_movie_view_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../data/movies/movie_repository.dart';
import '../../routing/inavigation_util.dart';
import '../../services/network/inetwork_service.dart';
import 'create_movie_view.dart';

class CreateMovieFactory {
  static Widget build() {
    return ChangeNotifierProvider(
        create: (context) => CreateMovieViewModel(
              movieRepository: MovieRepository(
                  networkService: context.read<INetworkService>()),
              navigationUtil: context.read<INavigationUtil>(),
            ),
        child: Consumer<CreateMovieViewModel>(
          builder: (context, model, child) => CreateMovieView(model: model),
        ));
  }
}
