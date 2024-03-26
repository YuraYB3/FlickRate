import 'package:flickrate/app/theme/color_palette.dart';
import 'package:flickrate/domain/review/ireview.dart';
import 'package:flutter/material.dart';

import '../../show_movies/widgets/movie_tile.dart';

class MovieReviews extends StatefulWidget {
  final ColorsPalette colorsPalette = ColorsPalette();
  final List<IReview> reviewData;
  final Function() moveToPreviousPage;
  final PageController pageController;
  MovieReviews(
      {super.key,
      required this.reviewData,
      required this.moveToPreviousPage,
      required this.pageController});

  @override
  State<MovieReviews> createState() => _MovieReviewsState();
}

class _MovieReviewsState extends State<MovieReviews> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height,
      child: Center(
        child: Column(
          children: [
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.9,
              child: ListView.builder(
                  itemBuilder: (context, index) {
                    final review = widget.reviewData[index];
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: MovieTile(
                        movieDescription: '',
                        movieGenre: review.movieGenre,
                        movieName: review.movieName,
                        onTileClicked: () {},
                      ),
                    );
                  },
                  itemCount: widget.reviewData.length),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                GestureDetector(
                  onTap: () {
                    widget.pageController.previousPage(
                      duration: const Duration(milliseconds: 300),
                      curve: Curves.easeInOut,
                    );
                    widget.moveToPreviousPage();
                  },
                  child: Container(
                    height: 10,
                    width: 10,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: widget.colorsPalette.secondColor,
                    ),
                  ),
                ),
                const SizedBox(
                  width: 20,
                ),
                GestureDetector(
                  onTap: () {},
                  child: Container(
                    height: 10,
                    width: 10,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: widget.colorsPalette.mainColor,
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
