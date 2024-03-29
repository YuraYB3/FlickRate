import 'package:flickrate/app/common/widgets/cached_image.dart';
import 'package:flickrate/app/screens/movies/movie_details/widgets/movie_bottom_navigation.dart';
import 'package:flickrate/app/theme/color_palette.dart';
import 'package:flickrate/domain/review/ireview.dart';
import 'package:flutter/material.dart';

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
      width: MediaQuery.of(context).size.width,
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
                      child: ListTile(
                        leading: SizedBox(
                          height: 50,
                          width: 50,
                          child: CachedImageWidget(
                              imageUrl: review.userImage,
                              height: 50,
                              shape: BoxShape.circle,
                              width: 50),
                        ),
                        title: Text(review.userName),
                        subtitle: Text(
                          review.reviewText,
                          maxLines: 50,
                          overflow: TextOverflow.ellipsis,
                        ),
                        trailing: Text(review.rating.toStringAsFixed(1)),
                      ),
                    );
                  },
                  itemCount: widget.reviewData.length),
            ),
            MovieBottomNavigation(
                pageController: widget.pageController,
                activeColor: widget.colorsPalette.secondColor,
                notActiveColor: widget.colorsPalette.mainColor,
                moveToNextPage: () {},
                moveToPreviousPage: widget.moveToPreviousPage),
            const SizedBox(
              height: 5,
            )
          ],
        ),
      ),
    );
  }
}
