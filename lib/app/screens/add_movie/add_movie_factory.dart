import 'package:flickrate/app/screens/add_movie/add_movie_view_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../data/movies/movie_repository.dart';
import '../../routing/inavigation_util.dart';
import '../../services/network/inetwork_service.dart';
import 'add_movie_view.dart';

class AddMovieFactory {
  static Widget build() {
    return ChangeNotifierProvider(
        create: (context) => AddMovieViewModel(
              movieRepository: MovieRepository(
                  networkService: context.read<INetworkService>()),
              navigationUtil: context.read<INavigationUtil>(),
            ),
        child: Consumer<AddMovieViewModel>(
          builder: (context, model, child) => AddMovieView(model: model),
        ));
  }
}
