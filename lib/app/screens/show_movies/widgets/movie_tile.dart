import 'package:flickrate/app/theme/color_palette.dart';
import 'package:flutter/material.dart';

import '../../../../domain/movies/imovie.dart';

class MovieTile extends StatelessWidget {
  final Function() onTileClicked;
  final ColorsPalette colorsPalette = ColorsPalette();
  MovieTile({
    required this.onTileClicked,
    super.key,
    required this.movie,
  });

  final IMovie movie;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: CircleAvatar(
        backgroundColor: colorsPalette.secondColor,
        child: Text(
          movie.name[0],
          style: const TextStyle(color: Colors.white),
        ),
      ),
      title: Text(movie.name),
      subtitle: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(movie.genre),
          const SizedBox(height: 4),
          Text(
            movie.description,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ),
      onTap: onTileClicked,
    );
  }
}
