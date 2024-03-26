import 'package:flickrate/app/screens/reviews/show_reviews/show_reviews_view_model.dart';
import 'package:flickrate/domain/review/ireview.dart';
import 'package:flutter/material.dart';

import '../../../common/screens/my_empty_screen.dart';
import '../../../common/screens/my_loading_widget.dart';
import '../../../theme/color_palette.dart';
import '../../movies/show_movies/widgets/movie_tile.dart';

class ShowReviewsView extends StatefulWidget {
  final ColorsPalette colorsPalette = ColorsPalette();
  final ShowReviewsViewModel model;

  ShowReviewsView({super.key, required this.model});
  @override
  State<ShowReviewsView> createState() => _ShowMoviesViewState();
}

class _ShowMoviesViewState extends State<ShowReviewsView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: widget.colorsPalette.mainColor,
      ),
      body: StreamBuilder<List<IReview>>(
        stream: widget.model.reviewStreamList,
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Center(child: MyLoadingScreen());
          }
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: MyLoadingScreen());
          }
          if (snapshot.data!.isEmpty) {
            return Center(child: MyEmptyScreen());
          }
          final reviewData = snapshot.data!;
          return ListView.builder(
              itemBuilder: (context, index) {
                final review = reviewData[index];
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: MovieTile(
                    movieDescription: '',
                    movieGenre: review.movieGenre,
                    movieName: review.movieName,
                    onTileClicked: () {
                      widget.model.onListTileClicked(review.movieId);
                    },
                  ),
                );
              },
              itemCount: reviewData.length);
        },
      ),
    );
  }
}
