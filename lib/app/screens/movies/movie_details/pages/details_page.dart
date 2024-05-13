import 'package:flickrate/app/common/widgets/cached_image.dart';
import 'package:flickrate/app/theme/color_palette.dart';
import 'package:flickrate/domain/movies/imovie.dart';
import 'package:flutter/material.dart';

import '../widgets/movie_bottom_navigation.dart';
import '../widgets/movie_description.dart';

class DetailsPage extends StatefulWidget {
  final IMovie movieData;
  final double screenHeight;
  final double screenWidth;

  const DetailsPage({
    super.key,
    required this.movieData,
    required this.screenHeight,
    required this.screenWidth,
  });

  @override
  State<DetailsPage> createState() => _DetailsPageState();
}

class _DetailsPageState extends State<DetailsPage> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: widget.screenHeight,
      child: Center(
        child: Column(
          children: [
            CachedImageWidget(
                imageUrl: widget.movieData.movieImg,
                width: widget.screenWidth,
                height: widget.screenHeight * 0.7,
                shape: BoxShape.rectangle),
            Expanded(
              child: MovieDescription(
                  description: widget.movieData.movieDescription),
            ),
            const MovieBottomNavigation(
              activeColor: mainColor,
              notActiveColor: secondaryColor,
            ),
            const SizedBox(
              height: 10,
            )
          ],
        ),
      ),
    );
  }
}
