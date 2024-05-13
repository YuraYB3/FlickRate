import 'package:flickrate/app/common/widgets/cached_image.dart';
import 'package:flutter/material.dart';

import '../../../../theme/color_palette.dart';

class MovieTile extends StatelessWidget {
  final Function() onTileClicked;
  const MovieTile({
    required this.onTileClicked,
    super.key,
    required this.movieName,
    required this.movieGenre,
    required this.movieDescription,
    required this.movieImage,
  });

  final String movieName;
  final String movieGenre;
  final String movieDescription;
  final String movieImage;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: CircleAvatar(
        backgroundColor: secondaryColor,
        child: CachedImageWidget(
          imageUrl: movieImage,
          height: 50,
          shape: BoxShape.circle,
          width: 50,
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
