import 'package:flutter/material.dart';

import '../../../data/genre/movie_genre.dart';
import '../../common/widgets/my_elevated_button.dart';
import '../../theme/color_palette.dart';
import 'create_movie_view_model.dart';

class CreateMovieView extends StatefulWidget {
  final CreateMovieViewModel model;

  const CreateMovieView({required this.model, super.key});

  @override
  State<CreateMovieView> createState() => _CreateMovieViewState();
}

class _CreateMovieViewState extends State<CreateMovieView> {
  final ColorsPalette colorsPalette = ColorsPalette();

  @override
  Widget build(BuildContext context) {
    double fieldWidth = MediaQuery.of(context).size.width * 0.8;
    double screenHeight = MediaQuery.of(context).size.height;
    //double screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: colorsPalette.mainColor,
        title: const Text('New Movie'),
      ),
      body: SizedBox(
        height: screenHeight,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              SizedBox(
                width: fieldWidth,
                child: TextField(
                  onChanged: (value) {
                    widget.model.updateMovieName(value);
                  },
                  decoration: const InputDecoration(
                    labelText: 'Movie name',
                  ),
                ),
              ),
              const SizedBox(height: 16),
              SizedBox(
                  width: fieldWidth,
                  child: DropdownButton(
                      hint: const Text('Select genre:'),
                      value: widget.model.movieGenre,
                      onChanged: (newValue) {
                        widget.model.updateMovieGenre(newValue!);
                      },
                      items: movieGenreList.map(
                        (movieGenre) {
                          return DropdownMenuItem(
                            value: movieGenre,
                            child: SizedBox(
                                width: fieldWidth, child: Text(movieGenre)),
                          );
                        },
                      ).toList())),
              const SizedBox(height: 16),
              Expanded(
                child: SizedBox(
                  width: fieldWidth,
                  child: TextField(
                    maxLines: 20,
                    onChanged: (value) {
                      widget.model.updateMovieDescription(value);
                    },
                    decoration: const InputDecoration(
                      labelText: 'Description',
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 16),
              MyElevatedButton(
                  title: 'Create movie',
                  onButtonPressed: () {
                    if (widget.model.isFieldsValid()) {
                      widget.model.onCreateMovieClicked();
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('Please, fill all the fields'),
                        ),
                      );
                    }
                  })
            ],
          ),
        ),
      ),
    );
  }
}
