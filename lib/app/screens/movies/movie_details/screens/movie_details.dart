import 'package:flickrate/app/theme/color_palette.dart';
import 'package:flickrate/domain/movies/imovie.dart';
import 'package:flutter/material.dart';

import '../widgets/movie_description.dart';
import '../widgets/movie_image.dart';

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
            MovieImage(
                screenHeight: widget.screenHeight,
                screenWidth: widget.screenWidth,
                imgUrl: widget.movieData.movieImg),
            Expanded(
              child: MovieDescription(
                  description: widget.movieData.movieDescription),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  height: 10,
                  width: 10,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: colorsPalette.mainColor,
                  ),
                ),
                const SizedBox(
                  width: 20,
                ),
                GestureDetector(
                  onTap: () {
                    widget.pageController.nextPage(
                      duration: const Duration(milliseconds: 300),
                      curve: Curves.easeInOut,
                    );
                    widget.moveToNextPage();
                  },
                  child: Container(
                    height: 10,
                    width: 10,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: colorsPalette.secondColor,
                    ),
                  ),
                ),
              ],
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
