import 'package:flutter/material.dart';

import '../../../../theme/color_palette.dart';

class MovieAppBar extends StatelessWidget implements PreferredSizeWidget {
  final ColorsPalette colorsPalette = ColorsPalette();
  final String movieName;
  final String movieRating;
  MovieAppBar({
    Key? key,
    required this.movieName,
    required this.movieRating,
  }) : super(key: key);

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    return AppBar(
        title: Text(movieName),
        backgroundColor: colorsPalette.mainColor,
        actions: [
          Padding(
            padding: const EdgeInsets.all(16),
            child: Text(
              movieRating,
              style: const TextStyle(fontSize: 24),
            ),
          )
        ]);
  }
}
