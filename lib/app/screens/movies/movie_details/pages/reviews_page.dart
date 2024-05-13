import 'package:flickrate/app/common/widgets/cached_image.dart';
import 'package:flickrate/app/screens/movies/movie_details/widgets/movie_bottom_navigation.dart';
import 'package:flickrate/app/theme/color_palette.dart';
import 'package:flickrate/domain/review/ireview.dart';
import 'package:flutter/material.dart';

class ReviewsPage extends StatefulWidget {
  final List<IReview> reviewData;
  final double screenHeight;
  final double screenWidth;
  const ReviewsPage({
    super.key,
    required this.reviewData,
    required this.screenHeight,
    required this.screenWidth,
  });

  @override
  State<ReviewsPage> createState() => _ReviewsPageState();
}

class _ReviewsPageState extends State<ReviewsPage> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: widget.screenHeight,
      width: widget.screenWidth,
      child: Center(
        child: Column(
          children: [
            Expanded(
              child: SizedBox(
                height: widget.screenHeight * 0.9,
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
      ),
    );
  }
}
