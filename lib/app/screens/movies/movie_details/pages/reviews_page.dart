import 'package:flickrate/app/common/screens/my_empty_screen.dart';
import 'package:flickrate/app/common/screens/my_error_widget.dart';
import 'package:flickrate/app/common/widgets/cached_image.dart';
import 'package:flickrate/app/common/widgets/my_loading_widget.dart';
import 'package:flickrate/app/screens/movies/movie_details/widgets/movie_bottom_navigation.dart';
import 'package:flickrate/app/theme/color_palette.dart';
import 'package:flickrate/domain/review/ireview.dart';
import 'package:flickrate/domain/user/i_my_user.dart';
import 'package:flutter/material.dart';

class ReviewsPage extends StatefulWidget {
  final double screenHeight;
  final double screenWidth;
  final Widget bottomButton;
  final Stream<List<IReview>> reviewStreamList;
  final Map<String, IMyUser> userMap;

  const ReviewsPage({
    super.key,
    required this.screenHeight,
    required this.screenWidth,
    required this.bottomButton,
    required this.reviewStreamList,
    required this.userMap,
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
              return const MyEmptyScreen();
            }
            var reviewData = snapshotReview.data!;
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
                              final review = reviewData[index];
                              final userData = widget.userMap[review.userId]!;
                              return Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: ListTile(
                                  leading: SizedBox(
                                    height: 50,
                                    width: 50,
                                    child: CachedImageWidget(
                                        imageUrl: userData.userProfileImage,
                                        height: 50,
                                        shape: BoxShape.circle,
                                        width: 50),
                                  ),
                                  title: Text(userData.userName),
                                  subtitle: Text(
                                    review.reviewText,
                                    maxLines: 50,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                  trailing:
                                      Text(review.rating.toStringAsFixed(1)),
                                ),
                              );
                            },
                            itemCount: reviewData.length),
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
          },
        ),
      ),
      bottomNavigationBar: widget.bottomButton,
    );
  }
}
