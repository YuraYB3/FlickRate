import 'package:flickrate/app/common/widgets/my_loading_widget.dart';
import 'package:flickrate/app/screens/movies/movie_details/pages/details_page.dart';
import 'package:flutter/material.dart';

import '../../../theme/color_palette.dart';
import 'movie_view_model.dart';
import 'pages/reviews_page.dart';
import 'widgets/create_review_form.dart';
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
  void initState() {
    widget._model.init();
    super.initState();
  }

  @override
  void didUpdateWidget(MovieScreen old) {
    super.didUpdateWidget(old);
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;
    return switch (widget._model.movieState) {
      MovieState.loading => const MyLoadingScreen(),
      MovieState.readyToWork => PageView(
          onPageChanged: (value) {
            widget._model.updateCurrentPageIndex(value);
          },
          children: [
            DetailsPage(
              shareMovie: widget._model.shareMovie,
              movie: widget._model.movie,
              screenHeight: screenHeight,
              screenWidth: screenWidth,
              onBackButtonClicked: widget._model.onBackButtonClicked,
            ),
            ReviewsPage(
              userMap: widget._model.userMap,
              reviewStreamList: widget._model.reviewStreamList,
              screenHeight: screenHeight,
              screenWidth: screenWidth,
              bottomButton: ShowReviewBottomSheetButton(
                movieName: widget._model.movie.movieName,
                buttonColor: mainColor,
                title: "Write review",
                reviewFormWidget: CreateReviewForm(
                    movie: widget._model.movie,
                    onBackButtonClicked: widget._model.onBackButtonClicked,
                    onCrateReviewClicked: widget._model.onCreateReviewClicked,
                    updateRating: widget._model.updateMovieRatingField,
                    updateReview: widget._model.updateMovieReviewField),
              ),
            )
          ],
        )
    };
  }
}
