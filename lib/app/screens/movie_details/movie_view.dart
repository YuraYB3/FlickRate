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
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          title: const Text("Delete movie"),
                          content: const Text(
                              "Are you sure you want to delete this movie?"),
                          actions: [
                            TextButton(
                              onPressed: () {
                                _model.onDeleteButtonPressed(_movie);
                                Navigator.of(context).pop();
                              },
                              child: Text(
                                "Delete",
                                style:
                                    TextStyle(color: colorsPalette.mainColor),
                              ),
                            ),
                            TextButton(
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                              child: const Text(
                                "Cancel",
                                style: TextStyle(color: Colors.black),
                              ),
                            ),
                          ],
                        );
                      },
                    );
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
