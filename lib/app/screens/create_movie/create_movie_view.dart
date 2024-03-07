import 'package:flutter/material.dart';

import '../../theme/color_palette.dart';
import 'create_movie_view_model.dart';
import 'widgets/create_movie_button.dart';
import 'widgets/my_descriptions_field.dart';
import 'widgets/my_movie_name_field.dart';
import 'widgets/select_genre_field.dart';

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
              MyMovieNameField(
                fieldWidth: fieldWidth,
                updateMovieName: (value) {
                  widget.model.updateMovieName(value);
                },
              ),
              const SizedBox(height: 16),
              SelectGenreField(
                fieldWidth: fieldWidth,
                movieGenre: widget.model.movieGenre,
                updateMovieGenre: (value) {
                  widget.model.updateMovieGenre(value);
                },
              ),
              const SizedBox(height: 16),
              Expanded(
                child: MyDescriptionField(
                  fieldWidth: fieldWidth,
                  updateMovieDescription: (value) {
                    widget.model.updateMovieDescription(value);
                  },
                ),
              ),
              const SizedBox(height: 16),
              CreateMovieButton(
                isFieldsValid: widget.model.isFieldsValid,
                onCreateMovieClicked: widget.model.onCreateMovieClicked,
              )
            ],
          ),
        ),
      ),
    );
  }
}
