import 'package:flutter/material.dart';

import '../../../../theme/color_palette.dart';

class MovieBar extends StatelessWidget {
  final ColorsPalette colorsPalette = ColorsPalette();
  final String movieName;
  final String movieRating;
  final Function() navigateBack;
  MovieBar({
    Key? key,
    required this.movieName,
    required this.movieRating,
    required this.navigateBack,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: colorsPalette.mainColor,
      child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
        IconButton(
          onPressed: navigateBack,
          icon: const Icon(
            Icons.arrow_back,
            color: Colors.white,
          ),
        ),
        Text(
          movieName.toUpperCase(),
          style: const TextStyle(color: Colors.white, fontSize: 18),
        ),
        Padding(
          padding: const EdgeInsets.all(16),
          child: Text(
            movieRating,
            style: const TextStyle(color: Colors.white, fontSize: 18),
          ),
        )
      ]),
    );
  }
}
