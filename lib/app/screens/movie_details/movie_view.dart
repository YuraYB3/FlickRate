import 'package:flickrate/app/common/widgets/my_elevated_button.dart';
import 'package:flickrate/app/screens/movie_details/movie_view_model.dart';
import 'package:flickrate/app/theme/color_palette.dart';
import 'package:flutter/material.dart';

import '../../../domain/movies/imovie.dart';

class MovieView extends StatelessWidget {
  final IMovie _movie;
  final MovieViewModel _model;
  final ColorsPalette colorsPalette = ColorsPalette();

  MovieView({Key? key, required IMovie movie, required MovieViewModel model})
      : _movie = movie,
        _model = model,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Text(_movie.name), backgroundColor: colorsPalette.mainColor),
      body: SizedBox(
        height: MediaQuery.of(context).size.height,
        child: Center(
          child: Column(
            children: [
              const SizedBox(
                height: 20,
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(_movie.description),
              ),
              const SizedBox(
                height: 20,
              ),
              const Expanded(child: SizedBox()),
              MyElevatedButton(
                  title: "Delete",
                  onButtonPressed: () {
                    _model.onDeleteButtonPressed(_movie);
                  }),
              const SizedBox(
                height: 50,
              )
            ],
          ),
        ),
      ),
    );
  }
}
