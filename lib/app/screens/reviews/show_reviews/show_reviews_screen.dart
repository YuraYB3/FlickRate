import 'package:flickrate/app/screens/reviews/show_reviews/show_reviews_view_model.dart';
import 'package:flickrate/domain/review/ireview.dart';
import 'package:flutter/material.dart';

import '../../../common/screens/my_empty_screen.dart';
import '../../../common/screens/my_loading_widget.dart';
import '../../../theme/color_palette.dart';

class ShowReviewsScreen extends StatefulWidget {
  final ShowReviewsViewModel model;

  const ShowReviewsScreen({super.key, required this.model});
  @override
  State<ShowReviewsScreen> createState() => _ShowMoviesViewState();
}

class _ShowMoviesViewState extends State<ShowReviewsScreen> {
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
            return const Center(child: MyLoadingScreen());
          }
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: MyLoadingScreen());
          }
          if (snapshot.data!.isEmpty) {
            return const Center(child: MyEmptyScreen());
          }
          final reviewData = snapshot.data!;
          return ListView.builder(
              itemBuilder: (context, index) {
                final review = reviewData[index];
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    decoration: BoxDecoration(
                        color: mainColor.withOpacity(0.7),
                        borderRadius:
                            const BorderRadius.all(Radius.circular(20))),
                    child: ListTile(
                      title: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          review.movieName,
                          style: const TextStyle(
                              color: Colors.white,
                              fontSize: 24,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                      trailing: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          review.rating.toStringAsFixed(1),
                          style: const TextStyle(color: Colors.white),
                        ),
                      ),
                    ),
                  ),
                );
              },
              itemCount: reviewData.length);
        },
      ),
    );
  }
}
