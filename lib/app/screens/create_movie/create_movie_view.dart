import 'package:flickrate/app/common/widgets/my_elevated_button.dart';
import 'package:flickrate/app/screens/create_movie/create_movie_view_model.dart';
import 'package:flickrate/app/theme/color_palette.dart';
import 'package:flutter/material.dart';

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
    return Scaffold(
      appBar: AppBar(
        backgroundColor: colorsPalette.mainColor,
        title: const Text('New Movie'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              TextField(
                onChanged: (value) {
                  widget.model.updateMovieName(value);
                },
                decoration: const InputDecoration(
                  labelText: 'Movie name',
                ),
              ),
              const SizedBox(height: 16),
              TextField(
                onChanged: (value) {
                  widget.model.updateMovieGenre(value);
                },
                decoration: const InputDecoration(
                  labelText: 'Genre',
                ),
              ),
              const SizedBox(height: 16),
              TextField(
                onChanged: (value) {
                  widget.model.updateMovieDescription(value);
                },
                maxLines: 16,
                decoration: const InputDecoration(
                  labelText: 'Description',
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
