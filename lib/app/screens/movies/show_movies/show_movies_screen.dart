import 'dart:developer';

import 'package:flutter/material.dart';

import '../../../../domain/movies/imovie.dart';
import '../../../theme/color_palette.dart';
import 'show_movies_view_model.dart';
import 'widgets/movie_tile.dart';
import 'widgets/search_bar_widget.dart';

class ShowMoviesScreen extends StatefulWidget {
  final ShowMoviesViewModel _model;
  const ShowMoviesScreen({required ShowMoviesViewModel model, super.key})
      : _model = model;

  @override
  State<ShowMoviesScreen> createState() => _ShowMoviesScreenState();
}

class _ShowMoviesScreenState extends State<ShowMoviesScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    widget._model.fetchMoviesStream();
    log("CHANGE");
  }

  @override
  void didUpdateWidget(covariant ShowMoviesScreen oldWidget) {
    super.didUpdateWidget(oldWidget);
    log("DID");
  }

  @override
  void activate() {
    super.activate();
    log("ACTIVATE");
  }

  @override
  void deactivate() {
    super.deactivate();
    log("DEACTIVATE");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: mainColor,
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
                              movieId: movie.documentId,
                              movieDescription: movie.movieDescription,
                              movieGenre: movie.movieGenre,
                              movieName: movie.movieName,
                              onTileClicked: widget._model.onListTileClicked,
                              movieImage: movie.movieImg,
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
