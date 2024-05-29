import 'package:flickrate/app/common/screens/my_error_widget.dart';
import 'package:flickrate/app/screens/reviews/show_reviews_view_model.dart';
import 'package:flickrate/app/screens/reviews/widgets/review_dialog.dart';
import 'package:flickrate/app/screens/reviews/widgets/user_review_tile.dart';
import 'package:flickrate/domain/review/ireview.dart';
import 'package:flutter/material.dart';

import '../../common/screens/my_empty_screen.dart';
import '../../common/widgets/my_loading_widget.dart';
import '../../theme/color_palette.dart';
import 'widgets/confirm_delete_dialog.dart';

class ShowReviewsScreen extends StatefulWidget {
  final ShowReviewsViewModel model;

  const ShowReviewsScreen({super.key, required this.model});
  @override
  State<ShowReviewsScreen> createState() => _ShowMoviesViewState();
}

class _ShowMoviesViewState extends State<ShowReviewsScreen> {
  @override
  void initState() {
    super.initState();

    widget.model.init();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: mainColor,
        foregroundColor: Colors.white,
      ),
      body: StreamBuilder<List<IReview>>(
        stream: widget.model.reviewStreamList,
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return const Center(child: MyErrorScreen());
          }
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: MyLoadingScreen(),
            );
          }
          if (snapshot.data!.isEmpty) {
            return MyEmptyScreen(
              mainText: widget.model.reviewType == ReviewLoadingType.byUserId
                  ? 'You do not have reviews yet'
                  : 'This category is empty',
              secondaryText: 'Write your first review!',
            );
          }
          final reviewData = snapshot.data!;
          return Column(
            children: [
              Expanded(
                child: ListView.builder(
                  itemBuilder: (context, index) {
                    final review = reviewData[index];
                    return GestureDetector(
                      onTap: () {
                        showDialog(
                          context: context,
                          builder: (context) {
                            return ReviewDialog(review: review);
                          },
                        );
                      },
                      onLongPress: () {
                        showDialog(
                          context: context,
                          builder: (context) {
                            return ConfirmDeleteDialog(
                              navigateBack: widget.model.navigateBack,
                              reviewId: review.documentId,
                              onConfirm: (widget.model.deleteReview),
                            );
                          },
                        );
                      },
                      child: UserReviewTile(
                        creationTime: review.creationTime,
                        getTimeAgoSinceDate: widget.model.getTimeAgoSinceDate,
                        reviewText: review.reviewText,
                        movieName: review.movieName,
                        rating: review.rating,
                      ),
                    );
                  },
                  itemCount: reviewData.length,
                ),
              ),
              //           SafeArea(child: MyElevatedButton(title: 'Add new review', buttonColor: mainColor, width: 150, onButtonPressed: (){}))
            ],
          );
        },
      ),
    );
  }
}
