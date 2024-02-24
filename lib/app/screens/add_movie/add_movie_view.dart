import 'package:flickrate/app/common/widgets/my_elevated_button.dart';
import 'package:flickrate/app/screens/add_movie/add_movie_view_model.dart';
import 'package:flickrate/app/theme/color_palette.dart';
import 'package:flutter/material.dart';

class AddMovieView extends StatelessWidget {
  final ColorsPalette colorsPalette;
  final AddMovieViewModel model;
  final TextEditingController nameController = TextEditingController();
  final TextEditingController genreController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  AddMovieView({required this.colorsPalette, required this.model, super.key});

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
                controller: nameController,
                decoration: const InputDecoration(
                  labelText: 'Movie Name',
                ),
              ),
              const SizedBox(height: 16),
              TextField(
                controller: genreController,
                decoration: const InputDecoration(
                  labelText: 'Genre',
                ),
              ),
              const SizedBox(height: 16),
              TextField(
                controller: descriptionController,
                maxLines: 16,
                decoration: const InputDecoration(
                  labelText: 'Description',
                ),
              ),
              const SizedBox(height: 16),
              MyElevatedButton(
                  title: 'Add movie',
                  onButtonPressed: () {
                    if (nameController.text.isNotEmpty &&
                        genreController.text.isNotEmpty &&
                        descriptionController.text.isNotEmpty) {
                      model.addMovie(nameController.text, genreController.text,
                          descriptionController.text);
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
