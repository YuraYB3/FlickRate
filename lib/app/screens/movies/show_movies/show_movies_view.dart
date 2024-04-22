import 'package:flutter/material.dart';

import '../../../../domain/movies/imovie.dart';
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
  void initState() {
    super.initState();
  }

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
      body: SingleChildScrollView(
        child: SizedBox(
          height: MediaQuery.of(context).size.height,
          child: Column(
            children: [
              Expanded(
                child: StreamBuilder<List<IMovie>>(
                  stream: widget._model.movieStreamList,
                  builder: (context, snapshot) {
                    if (snapshot.hasError) {
                      return Center(
                        child: Text(
                          "ERROR${snapshot.error}",
                          style: const TextStyle(
                              color: Colors.white, fontSize: 24),
                        ),
                      );
                    }
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Center(
                        child: CircularProgressIndicator(
                          color: Colors.white,
                        ),
                      );
                    }
                    final List<IMovie> movieData = snapshot.data!;
                    return ListView.builder(
                        itemBuilder: (context, index) {
                          final movie = movieData[index];
                          return Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: MovieTile(
                              movieDescription: movie.movieDescription,
                              movieGenre: movie.movieGenre,
                              movieName: movie.movieName,
                              onTileClicked: () {
                                widget._model
                                    .onListTileClicked(movie.documentId);
                              },
                            ),
                          );
                        },
                        itemCount: movieData.length);
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
