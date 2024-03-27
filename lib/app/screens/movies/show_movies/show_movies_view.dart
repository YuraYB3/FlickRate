import 'package:flutter/material.dart';

import '../../../../domain/movies/imovie.dart';
import '../../../common/screens/my_empty_screen.dart';
import '../../../common/screens/my_error_widget.dart';
import '../../../common/screens/my_loading_widget.dart';
import '../../../theme/color_palette.dart';
import 'show_movies_view_model.dart';
import 'widgets/movie_tile.dart';
import 'widgets/search_bar_widget.dart';

class ShowMoviesView extends StatefulWidget {
  final ShowMoviesViewModel _model;
  final ColorsPalette colorsPalette = ColorsPalette();
  ShowMoviesView({required ShowMoviesViewModel model, super.key})
      : _model = model;

  @override
  State<ShowMoviesView> createState() => _ShowMoviesViewState();
}

class _ShowMoviesViewState extends State<ShowMoviesView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: widget.colorsPalette.mainColor,
        toolbarHeight: 80,
        title: SearchBarWidget(
          updateSearchQuery: (value) {
            widget._model.updateSearchQuery(value);
          },
        ),
      ),
      body: StreamBuilder<List<IMovie>>(
        stream: widget._model.movieStreamList,
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return const Center(child: MyErrorScreen());
          }
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: MyLoadingScreen());
          }
          if (snapshot.data!.isEmpty) {
            return Center(child: MyEmptyScreen());
          }
          final moviesData = snapshot.data!;
          return ListView.builder(
              itemBuilder: (context, index) {
                final movie = moviesData[index];
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: MovieTile(
                    movieDescription: movie.movieDescription,
                    movieGenre: movie.movieGenre,
                    movieName: movie.movieName,
                    onTileClicked: () {
                      widget._model.onListTileClicked(movie.documentId);
                    },
                  ),
                );
              },
              itemCount: moviesData.length);
        },
      ),
    );
  }
}
