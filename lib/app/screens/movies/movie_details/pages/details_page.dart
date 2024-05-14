import 'package:flickrate/app/common/widgets/cached_image.dart';
import 'package:flickrate/app/theme/color_palette.dart';
import 'package:flickrate/domain/movies/imovie.dart';
import 'package:flutter/material.dart';

import '../widgets/movie_app_bar.dart';
import '../widgets/movie_bottom_navigation.dart';
import '../widgets/movie_description.dart';

class DetailsPage extends StatefulWidget {
  final IMovie movie;
  final double screenHeight;
  final double screenWidth;
  final Function onBackButtonClicked;
  final Function shareMovie;

  const DetailsPage({
    super.key,
    required this.movie,
    required this.screenHeight,
    required this.screenWidth,
    required this.onBackButtonClicked,
    required this.shareMovie,
  });

  @override
  State<DetailsPage> createState() => _DetailsPageState();
}

class _DetailsPageState extends State<DetailsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox(
        height: widget.screenHeight,
        child: Center(
          child: Column(
            children: [
              CachedImageWidget(
                  imageUrl: widget.movie.movieImg,
                  width: widget.screenWidth,
                  height: widget.screenHeight * 0.7,
                  shape: BoxShape.rectangle),
              Expanded(
                child: MovieDescription(
                    description: widget.movie.movieDescription),
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
      ),
      bottomNavigationBar: MovieBar(
        shareMovie: widget.shareMovie,
        navigateBack: widget.onBackButtonClicked,
        movieName: widget.movie.movieName,
        movieRating: widget.movie.movieRating.toString(),
      ),
    );
  }
}
