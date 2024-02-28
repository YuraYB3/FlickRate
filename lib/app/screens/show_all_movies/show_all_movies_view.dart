import 'package:flickrate/app/theme/color_palette.dart';
import 'package:flutter/material.dart';

import '../../../domain/movies/imovie.dart';
import 'show_all_movies_view_model.dart';

class ShowAllMoviesView extends StatefulWidget {
  final ShowAllMoviesViewModel _model;
  final ColorsPalette colorsPalette = ColorsPalette();
  ShowAllMoviesView({required ShowAllMoviesViewModel model, super.key})
      : _model = model;

  @override
  State<ShowAllMoviesView> createState() => _ShowAllMoviesViewState();
}

class _ShowAllMoviesViewState extends State<ShowAllMoviesView> {
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
                        widget._model.onListTileClicked(movie);
                      },
                    ),
                  );
                },
                itemCount: moviesData.length);
          },
        ));
  }
}
