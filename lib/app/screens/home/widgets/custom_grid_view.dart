import 'package:flutter/widgets.dart';

import '../../../../data/genre/movie_genre.dart';
import 'genre_item.dart';

class CustomGridView extends StatelessWidget {
  const CustomGridView({
    super.key,
    required this.onGenreTileClicked,
  });
  final Function onGenreTileClicked;

  @override
  Widget build(BuildContext context) {
    return GridView(
      padding: const EdgeInsets.symmetric(horizontal: 25),
      gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
          maxCrossAxisExtent: 200,
          childAspectRatio: 3 / 2,
          crossAxisSpacing: 20,
          mainAxisSpacing: 20),
      children: MovieGenre.values
          .map((genreItem) => GenreItem(
                title: genreItem.name,
                onTileClicked: () {
                  onGenreTileClicked(genreItem.name);
                },
              ))
          .toList(),
    );
  }
}
