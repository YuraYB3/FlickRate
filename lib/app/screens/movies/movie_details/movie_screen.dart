import 'package:flickrate/app/screens/movies/movie_details/pages/details_page.dart';
import 'package:flickrate/app/screens/movies/movie_details/pages/reviews_page.dart';
import 'package:flickrate/app/screens/movies/movie_details/widgets/create_review_form.dart';
import 'package:flutter/material.dart';

import '../../../../domain/movies/imovie.dart';
import '../../../../domain/review/ireview.dart';
import '../../../common/screens/my_empty_screen.dart';
import '../../../common/screens/my_error_widget.dart';
import '../../../common/screens/my_loading_widget.dart';
import '../../../theme/color_palette.dart';
import 'movie_view_model.dart';
import 'widgets/movie_app_bar.dart';
import 'widgets/show_review_bottom_sheet_button.dart.dart';

class MovieScreen extends StatefulWidget {
  final MovieViewModel _model;

  const MovieScreen({super.key, required MovieViewModel model})
      : _model = model;

  @override
  State<MovieScreen> createState() => _MovieScreenState();
}

class _MovieScreenState extends State<MovieScreen> {
  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;
    return StreamBuilder<IMovie>(
      stream: widget._model.movieStream,
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return showErrorScreen();
        }
        if (snapshot.connectionState == ConnectionState.waiting) {
          return showLoadingScreen();
        }
        final movieData = snapshot.data!;
        return StreamBuilder<List<IReview>>(
          stream: widget._model.reviewStreamList,
          builder: (context, snapshot) {
            if (snapshot.hasError) {
              return showErrorScreen();
            }
            if (snapshot.connectionState == ConnectionState.waiting) {
              return showLoadingScreen();
            }
            final reviewData = snapshot.data!;
            return Scaffold(
              body: PageView(
                onPageChanged: (value) {
                  widget._model.updateCurrentPageIndex(value);
                },
                children: [
                  DetailsPage(
                    movieData: movieData,
                    screenHeight: screenHeight,
                    screenWidth: screenWidth,
                  ),
                  reviewData.isEmpty
                      ? showEmptyScreen()
                      : ReviewsPage(
                          reviewData: reviewData,
                          screenHeight: screenHeight,
                          screenWidth: screenWidth,
                        )
                ],
              ),
              bottomNavigationBar: widget._model.currentPageIndex == 0
                  ? MovieBar(
                      navigateBack: widget._model.onBackButtonClicked,
                      movieName: movieData.movieName,
                      movieRating: movieData.movieRating.toString(),
                    )
                  : ShowReviewBottomSheetButton(
                      movieName: movieData.movieName,
                      buttonColor: mainColor,
                      title: "Write review",
                      reviewFormWidget: CreateReviewForm(
                          movieName: movieData.movieName,
                          onBackButtonClicked:
                              widget._model.onBackButtonClicked,
                          onCrateReviewClicked:
                              widget._model.onCreateReviewClicked,
                          updateRating: widget._model.updateMovieRatingField,
                          updateReview: widget._model.updateMovieReviewField),
                    ),
            );
          },
        );
      },
    );
  }

  MyEmptyScreen showEmptyScreen() => const MyEmptyScreen();

  MyErrorScreen showErrorScreen() => const MyErrorScreen();

  Scaffold showLoadingScreen() => const Scaffold(body: MyLoadingScreen());
}
