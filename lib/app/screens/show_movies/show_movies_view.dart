import 'package:flutter/material.dart';

import '../../../domain/movies/imovie.dart';
import '../../theme/color_palette.dart';
import 'show_movies_view_model.dart';

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
      ),
      body: StreamBuilder<List<IMovie>>(
        stream: widget._model.movieStreamList,
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return const Center(
              child: Text('ERROR'),
            );
          }
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(
                color: widget.colorsPalette.mainColor,
              ),
            );
          }
          if (snapshot.data!.isEmpty) {
            return Center(
                child: Text(
              "EMPTY :(",
              style: TextStyle(
                  fontSize: 24, color: widget.colorsPalette.mainColor),
            ));
          }
          final moviesData = snapshot.data!;
          return ListView.builder(
              itemBuilder: (context, index) {
                final movie = moviesData[index];
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ListTile(
                    leading: CircleAvatar(
                      backgroundColor: widget.colorsPalette.secondColor,
                      child: Text(
                        movie.name[0],
                        style: const TextStyle(color: Colors.white),
                      ),
                    ),
                    title: Text(movie.name),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(movie.genre),
                        const SizedBox(height: 4),
                        Text(
                          movie.description,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ],
                    ),
                    onTap: () {
                      widget._model.onListTileClicked(movie.id);
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
