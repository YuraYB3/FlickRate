import 'package:flutter/material.dart';

import '../../../../theme/color_palette.dart';

class MovieBar extends StatelessWidget {
  final String movieName;
  final String movieRating;
  final Function navigateBack;
  final Function shareMovie;
  const MovieBar({
    super.key,
    required this.movieName,
    required this.movieRating,
    required this.navigateBack,
    required this.shareMovie,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 80,
      color: mainColor,
      child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
        IconButton(
          onPressed: () {
            navigateBack();
          },
          icon: const Icon(
            Icons.arrow_back,
            color: Colors.white,
          ),
        ),
        Text(
          movieName.toUpperCase(),
          style: const TextStyle(color: Colors.white, fontSize: 18),
        ),
        IconButton(
          onPressed: () {
            shareMovie();
          },
          icon: const Icon(
            Icons.share,
            color: Colors.white,
          ),
        ),
      ]),
    );
  }
}
