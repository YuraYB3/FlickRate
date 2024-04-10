import 'package:flickrate/app/common/widgets/my_elevated_button.dart';
import 'package:flickrate/app/screens/movies/movie_details/screens/create_review_form.dart';
import 'package:flickrate/app/screens/movies/movie_details/screens/movie_details.dart';
import 'package:flickrate/app/screens/movies/movie_details/screens/movie_reviews.dart';
import 'package:flutter/material.dart';

import '../../../../domain/movies/imovie.dart';
import '../../../../domain/review/ireview.dart';
import '../../../common/screens/my_empty_screen.dart';
import '../../../common/screens/my_error_widget.dart';
import '../../../common/screens/my_loading_widget.dart';
import '../../../common/widgets/custom_snackbar.dart';
import '../../../theme/color_palette.dart';
import 'movie_view_model.dart';
import 'widgets/movie_app_bar.dart';

class MovieView extends StatefulWidget {
  final MovieViewModel _model;

  const MovieView({super.key, required MovieViewModel model}) : _model = model;

  @override
  State<MovieView> createState() => _MovieViewState();
}

class _MovieViewState extends State<MovieView> {
  final ColorsPalette colorsPalette = ColorsPalette();

  @override
  void dispose() {
    widget._model.pageController.dispose();
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
              return showLoadingScreen();
            }
            if (snapshot.connectionState == ConnectionState.waiting) {
              return showLoadingScreen();
            }
            final reviewData = snapshot.data!;
            return Scaffold(
              bottomNavigationBar: widget._model.currentPageIndex == 0
                  ? MovieBar(
                      navigateBack: widget._model.onBackButtonClicked,
                      movieName: movieData.movieName,
                      movieRating: movieData.movieRating.toString(),
                    )
                  : MyElevatedButton(
                      buttonColor: widget._model.isShowCreateReviewFormClicked
                          ? colorsPalette.secondColor
                          : colorsPalette.mainColor,
                      title: widget._model.isShowCreateReviewFormClicked
                          ? "Cancel"
                          : "Write review",
                      width: double.infinity,
                      onButtonPressed:
                          widget._model.onShowCreateReviewFormClicked),
              body: GestureDetector(
                onHorizontalDragEnd: (details) {
                  if (details.primaryVelocity! > 0 &&
                      widget._model.currentPageIndex > 0) {
                    widget._model.pageController.previousPage(
                      duration: const Duration(milliseconds: 300),
                      curve: Curves.easeInOut,
                    );
                    widget._model.moveToPreviousPage();
                  } else if (details.primaryVelocity! < 0 &&
                      widget._model.currentPageIndex < 1) {
                    widget._model.pageController.nextPage(
                      duration: const Duration(milliseconds: 300),
                      curve: Curves.easeInOut,
                    );
                    widget._model.moveToNextPage();
                  }
                },
                child: PageView(
                  controller: widget._model.pageController,
                  onPageChanged: (int index) {
                    widget._model.setCurrentPageIndex(index);
                  },
                  children: [
                    MovieDetails(
                        movieData: movieData,
                        screenHeight: screenHeight,
                        screenWidth: screenWidth,
                        pageController: widget._model.pageController,
                        moveToNextPage: widget._model.moveToNextPage),
                    widget._model.isShowCreateReviewFormClicked
                        ? CreateReviewForm(
                            movieName: movieData.movieName,
                            rating: widget._model.movieRating,
                            updateRating: (value) {
                              widget._model.updateMovieRatingField(value);
                            },
                            updateReview: (value) {
                              widget._model.updateMovieReviewField(value);
                            },
                            onCrateReviewClicked: () {
                              widget._model.onCreateReviewClicked(
                                showError: (message) =>
                                    showCustomSnackBar(context, message),
                                showSuccess: (message) => showCustomSnackBar(
                                    context, message,
                                    backgroundColor: Colors.green),
                              );
                            })
                        : reviewData.isEmpty
                            ? showEmptyScreen()
                            : MovieReviews(
                                reviewData: reviewData,
                                moveToPreviousPage:
                                    widget._model.moveToPreviousPage,
                                pageController: widget._model.pageController,
                              )
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }

  MyEmptyScreen showEmptyScreen() => MyEmptyScreen();

  MyErrorScreen showErrorScreen() => const MyErrorScreen();

  Scaffold showLoadingScreen() => Scaffold(body: MyLoadingScreen());
}
