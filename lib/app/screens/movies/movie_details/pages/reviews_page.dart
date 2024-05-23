import 'package:flickrate/app/common/screens/my_empty_screen.dart';
import 'package:flickrate/app/common/screens/my_error_widget.dart';
import 'package:flickrate/app/common/widgets/my_loading_widget.dart';
import 'package:flickrate/app/screens/movies/movie_details/widgets/movie_bottom_navigation.dart';
import 'package:flickrate/app/screens/movies/movie_details/widgets/review_tile.dart';
import 'package:flickrate/app/theme/color_palette.dart';
import 'package:flickrate/domain/movies/imovie.dart';
import 'package:flickrate/domain/review/ireview.dart';
import 'package:flickrate/domain/user/i_my_user.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating/flutter_rating.dart';

class ReviewsPage extends StatefulWidget {
  final double screenHeight;
  final double screenWidth;
  final Widget bottomButton;
  final Stream<List<IReview>> reviewStreamList;
  final Map<String, IMyUser> userMap;
  final IMovie movie;
  final Function getTimeAgoSinceDate;

  const ReviewsPage({
    super.key,
    required this.screenHeight,
    required this.screenWidth,
    required this.bottomButton,
    required this.reviewStreamList,
    required this.userMap,
    required this.movie,
    required this.getTimeAgoSinceDate,
  });

  @override
  State<ReviewsPage> createState() => _ReviewsPageState();
}

class _ReviewsPageState extends State<ReviewsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox(
        height: widget.screenHeight,
        child: StreamBuilder<List<IReview>>(
          stream: widget.reviewStreamList,
          builder: (context, snapshotReview) {
            if (snapshotReview.hasError) {
              return const MyErrorScreen();
            }
            if (snapshotReview.connectionState == ConnectionState.waiting) {
              return const MyLoadingScreen();
            }
            if (snapshotReview.data!.isEmpty) {
              return const MyEmptyScreen(
                mainText: 'No Reviews Yet',
                secondaryText: 'Be the first to write a review!',
              );
            }
            var reviewData = snapshotReview.data!;
            return SizedBox(
              height: widget.screenHeight,
              width: widget.screenWidth,
              child: Column(
                children: [
                  Expanded(
                    child: ListView.builder(
                        itemBuilder: (context, index) {
                          final IReview review = reviewData[index];
                          final IMyUser userData =
                              widget.userMap[review.userId]!;
                          return ReviewTile(
                              userData: userData,
                              review: review,
                              getTimeAgoSinceDate: widget.getTimeAgoSinceDate);
                        },
                        itemCount: reviewData.length),
                  ),
                  SizedBox(
                    child: Text(
                      widget.movie.movieRating.toStringAsFixed(1),
                      style: const TextStyle(
                          color: Colors.black,
                          fontSize: 64,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                  StarRating(
                    size: 30.0,
                    rating: widget.movie.movieRating.toDouble(),
                    color: Colors.orange,
                    borderColor: Colors.grey,
                    allowHalfRating: true,
                    starCount: 5,
                  ),
                  SizedBox(
                    child: Text(
                        'Based on ${widget.movie.numberOfReviews} reviews'),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  const MovieBottomNavigation(
                    activeColor: secondaryColor,
                    notActiveColor: mainColor,
                  ),
                  const SizedBox(
                    height: 10,
                  )
                ],
              ),
            );
          },
        ),
      ),
      bottomNavigationBar: widget.bottomButton,
    );
  }
}
