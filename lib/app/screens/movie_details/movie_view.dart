import 'package:flutter/material.dart';

import '../../../domain/movies/imovie.dart';
import '../../common/widgets/custom_snackbar.dart';
import '../../common/widgets/my_error_widget.dart';
import '../../common/widgets/my_loading_widget.dart';
import '../../theme/color_palette.dart';
import 'movie_view_model.dart';
import 'widgets/decrease_rating.button.dart';
import 'widgets/delete_movie_button.dart';
import 'widgets/movie_app_bar.dart';
import 'widgets/increase_rating_button.dart';
import 'widgets/movie_description.dart';
import 'widgets/movie_image.dart';

class MovieView extends StatelessWidget {
  final MovieViewModel _model;
  final ColorsPalette colorsPalette = ColorsPalette();

  MovieView({Key? key, required MovieViewModel model})
      : _model = model,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;
    return StreamBuilder<IMovie>(
      stream: _model.movieStream,
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return const MyErrorWidget();
        }
        if (snapshot.connectionState == ConnectionState.waiting) {
          return MyLoadingWidget();
        }
        final movieData = snapshot.data!;
        return Scaffold(
          appBar: MovieAppBar(
            movieName: movieData.name,
            movieRating: movieData.rating.toString(),
          ),
          body: SizedBox(
            height: MediaQuery.of(context).size.height,
            child: Center(
              child: Column(
                children: [
                  MovieImage(
                      screenHeight: screenHeight, screenWidth: screenWidth),
                  Expanded(
                      child:
                          MovieDescription(description: movieData.description)),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      DecreaseRatingButton(
                        onButtonClicked: () {
                          _model.onDecreaseButtonClicked(
                            movieId: movieData.documentId,
                            showException: (message) =>
                                showCustomSnackBar(context, message),
                          );
                        },
                      ),
                      DeleteMovieButton(onDeleteButtonPressed: () {
                        _model.onDeleteButtonPressed(
                          movieId: movieData.documentId,
                          showException: (message) =>
                              showCustomSnackBar(context, message),
                        );
                      }),
                      IncreaseRatingButton(onButtonClicked: () {
                        _model.onIncreaseButtonClicked(
                          movieId: movieData.documentId,
                          showException: (message) =>
                              showCustomSnackBar(context, message),
                        );
                      }),
                    ],
                  ),
                  const SizedBox(
                    height: 20,
                  )
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
