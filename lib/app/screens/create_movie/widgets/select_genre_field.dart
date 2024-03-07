import 'package:flutter/material.dart';

import '../../../../data/genre/movie_genre.dart';

class SelectGenreField extends StatelessWidget {
  final double fieldWidth;
  final String movieGenre;
  final Function(String value) updateMovieGenre;
  const SelectGenreField({
    super.key,
    required this.fieldWidth,
    required this.updateMovieGenre,
    required this.movieGenre,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        width: fieldWidth,
        child: DropdownButton(
            hint: const Text('Select genre:'),
            value: movieGenre,
            onChanged: (value) {
              updateMovieGenre(value!);
            },
            items: movieGenreList.map(
              (movieGenre) {
                return DropdownMenuItem(
                  value: movieGenre,
                  child: SizedBox(width: fieldWidth, child: Text(movieGenre)),
                );
              },
            ).toList()));
  }
}
