import 'package:flickrate/app/common/widgets/cached_image.dart';
import 'package:flickrate/app/theme/color_palette.dart';
import 'package:flickrate/domain/movies/imovie.dart';
import 'package:flutter/material.dart';

import '../widgets/movie_bottom_navigation.dart';
import '../widgets/movie_description.dart';

class MovieDetails extends StatefulWidget {
  final IMovie movieData;
  final double screenHeight;
  final double screenWidth;
  final Function() moveToNextPage;
  final PageController pageController;

  const MovieDetails(
      {super.key,
      required this.movieData,
      required this.screenHeight,
      required this.screenWidth,
      required this.pageController,
      required this.moveToNextPage});

  @override
  State<MovieDetails> createState() => _MovieDetailsState();
}

class _MovieDetailsState extends State<MovieDetails> {
  ColorsPalette colorsPalette = ColorsPalette();

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height,
      child: Center(
        child: Column(
          children: [
            CachedImageWidget(
                imageUrl: widget.movieData.movieImg,
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height * 0.7,
                shape: BoxShape.rectangle),
            Expanded(
              child: MovieDescription(
                  description: widget.movieData.movieDescription),
            ),
            MovieBottomNavigation(
              activeColor: colorsPalette.mainColor,
              notActiveColor: colorsPalette.secondColor,
              pageController: widget.pageController,
              moveToNextPage: widget.moveToNextPage,
              moveToPreviousPage: () {},
            ),
            const SizedBox(
              height: 5,
            )
          ],
        ),
      ),
    );
  }
}
