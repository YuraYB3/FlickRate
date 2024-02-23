import 'package:flickrate/app/screens/add_movie/add_movie_view_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../routing/inavigation_util.dart';
import 'add_movie_view.dart';

class AddMovieFactory {
  static Widget build() {
    return ChangeNotifierProvider(
        create: (context) => AddMovieViewModel(
              navigationUtil: context.read<INavigationUtil>(),
            ),
        child: Consumer<AddMovieViewModel>(
          builder: (context, model, child) => AddMovieView(model: model),
        ));
  }
}
