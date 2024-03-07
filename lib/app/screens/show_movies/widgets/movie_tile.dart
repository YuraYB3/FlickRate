import 'package:flutter/material.dart';

import '../../../theme/color_palette.dart';

class MovieTile extends StatelessWidget {
  final Function() onTileClicked;
  final ColorsPalette colorsPalette = ColorsPalette();
  MovieTile({
    required this.onTileClicked,
    super.key,
    required this.movieName,
    required this.movieGenre,
    required this.movieDescription,
  });

  final String movieName;
  final String movieGenre;
  final String movieDescription;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: CircleAvatar(
        backgroundColor: colorsPalette.secondColor,
        child: Text(
          movieName[0],
          style: const TextStyle(color: Colors.white),
        ),
      ),
      title: Text(movieName),
      subtitle: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(movieGenre),
          const SizedBox(height: 4),
          Text(
            movieDescription,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ),
      onTap: onTileClicked,
    );
  }
}
