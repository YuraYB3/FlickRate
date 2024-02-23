import 'package:flickrate/app/routing/inavigation_util.dart';
import 'package:flickrate/data/movie.dart';
import 'package:flutter/material.dart';

class AddMovieViewModel extends ChangeNotifier {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController genreController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();

  final INavigationUtil _navigationUtil;

  AddMovieViewModel({required INavigationUtil navigationUtil})
      : _navigationUtil = navigationUtil;

  String get name => nameController.text;
  String get genre => genreController.text;
  String get description => descriptionController.text;

  bool get isFormValid =>
      name.isNotEmpty && genre.isNotEmpty && description.isNotEmpty;

  void addMovie() {
    MovieModel()
        .addMovie(Movie(name: name, genre: genre, description: description));
    _navigationUtil.navigateBack();
  }
}
