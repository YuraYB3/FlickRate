import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../data/movies/movie_repository.dart';
import '../../routing/inavigation_util.dart';
import '../../services/functions/ifunction_service.dart';
import '../../services/network/inetwork_service.dart';
import 'create_movie_view.dart';
import 'create_movie_view_model.dart';

class CreateMovieFactory {
  static Widget build() {
    return ChangeNotifierProvider(
        create: (context) => CreateMovieViewModel(
              movieRepository: MovieRepository(
                  functionService: context.read<IFunctionService>(),
                  networkService: context.read<INetworkService>()),
              navigationUtil: context.read<INavigationUtil>(),
            ),
        child: Consumer<CreateMovieViewModel>(
          builder: (context, model, child) => CreateMovieView(model: model),
        ));
  }
}
