import 'dart:developer';

import 'package:flickrate/app/common/screens/my_empty_screen.dart';
import 'package:flutter/material.dart';

import '../../../../domain/movies/imovie.dart';
import '../../../theme/color_palette.dart';
import 'show_movies_view_model.dart';
import 'widgets/movie_tile.dart';
import 'widgets/search_bar_widget.dart';

class ShowMoviesScreen extends StatefulWidget {
  final ShowMoviesViewModel model;
  const ShowMoviesScreen({required ShowMoviesViewModel viewModel, super.key})
      : model = viewModel;

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
    widget.model.fetchMoviesStream();
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
            widget.model.updateSearchQuery(value);
          },
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 10),
            child: IconButton(
              onPressed: widget.model.onSearchButtonClicked,
              icon: const Icon(
                Icons.search,
                color: Colors.white,
              ),
            ),
          )
        ],
      ),
      body: SafeArea(
        child: StreamBuilder<List<IMovie>>(
          stream: widget.model.movieStreamList,
          builder: (context, snapshot) {
            if (snapshot.hasError) {
              return Center(
                child: Text(
                  "ERROR${snapshot.error}",
                  style: const TextStyle(color: Colors.white, fontSize: 24),
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
            if (movieData.isEmpty) {
              return const Center(
                child: MyEmptyScreen(
                    mainText: 'Cant find this movie', secondaryText: 'Check the title again'),
              );
            }
            log(movieData.isEmpty.toString());
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
                      onTileClicked: widget.model.onListTileClicked,
                      movieImage: movie.movieImg,
                    ),
                  );
                },
                itemCount: movieData.length);
          },
        ),
      ),
    );
  }
}
