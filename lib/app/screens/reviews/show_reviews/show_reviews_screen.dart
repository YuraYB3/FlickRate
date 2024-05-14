import 'package:flickrate/app/common/screens/my_error_widget.dart';
import 'package:flickrate/app/screens/reviews/show_reviews/show_reviews_view_model.dart';
import 'package:flickrate/app/screens/reviews/widgets/review_dialog.dart';
import 'package:flickrate/app/screens/reviews/widgets/review_tile.dart';
import 'package:flickrate/domain/review/ireview.dart';
import 'package:flutter/material.dart';

import '../../../common/screens/my_empty_screen.dart';
import '../../../common/widgets/my_loading_widget.dart';
import '../../../theme/color_palette.dart';
import '../widgets/confirm_delete_dialog.dart';

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
            return const Center(
              child: MyEmptyScreen(),
            );
          }
          final reviewData = snapshot.data!;
          return ListView.builder(
            itemBuilder: (context, index) {
              final review = reviewData[index];
              return Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: const BorderRadius.all(Radius.circular(15)),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.1),
                        spreadRadius: 2,
                        blurRadius: 5,
                        offset: const Offset(0, 3),
                      ),
                    ],
                  ),
                  child: GestureDetector(
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
                      child: ReviewTile(
                        movieName: review.movieName,
                        rating: review.rating.toStringAsFixed(1),
                      )),
                ),
              );
            },
            itemCount: reviewData.length,
          );
        },
      ),
    );
  }
}
