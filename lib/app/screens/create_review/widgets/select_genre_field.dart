import 'package:flutter/material.dart';

import '../../../../data/genre/movie_genre.dart';

class SelectGenreField extends StatelessWidget {
  final double fieldWidth;
  final MovieGenre movieGenre;
  final Function(MovieGenre value) updateMovieGenre;
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
      child: DropdownButton<MovieGenre>(
        hint: const Text('Select genre:'),
        value: movieGenre,
        onChanged: (value) {
          updateMovieGenre(value!);
        },
        items: MovieGenre.values.map(
          (movieGenre) {
            return DropdownMenuItem(
              value: movieGenre,
              child: SizedBox(width: fieldWidth, child: Text(movieGenre.name)),
            );
          },
        ).toList(),
      ),
    );
  }
}
