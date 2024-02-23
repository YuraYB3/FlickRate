import 'package:flickrate/app/common/widgets/my_elevated_button.dart';
import 'package:flickrate/app/screens/add_movie/add_movie_view_model.dart';
import 'package:flickrate/app/theme/color_palete.dart';
import 'package:flutter/material.dart';

class AddMovieView extends StatelessWidget {
  final ColorsPalete colorsPalete = ColorsPalete();
  final AddMovieViewModel model;
  AddMovieView({required this.model, super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: colorsPalete.mainColor,
        title: const Text('New Movie'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              TextField(
                controller: model.nameController,
                decoration: const InputDecoration(
                  labelText: 'Movie Name',
                ),
              ),
              const SizedBox(height: 16),
              TextField(
                controller: model.genreController,
                decoration: const InputDecoration(
                  labelText: 'Genre',
                ),
              ),
              const SizedBox(height: 16),
              TextField(
                controller: model.descriptionController,
                maxLines: 16,
                decoration: const InputDecoration(
                  labelText: 'Description',
                ),
              ),
              const SizedBox(height: 16),
              MyElevatedButton(
                  title: 'Add movie',
                  onButtonPressed: () {
                    if (model.isFormValid) {
                      model.addMovie();
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('Please, fill all fields'),
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
