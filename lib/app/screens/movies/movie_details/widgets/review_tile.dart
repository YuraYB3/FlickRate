import 'package:flutter/material.dart';
import 'package:flutter_rating/flutter_rating.dart';

import '../../../../../domain/review/ireview.dart';
import '../../../../../domain/user/i_my_user.dart';
import '../../../../common/widgets/cached_image.dart';

class ReviewTile extends StatelessWidget {
  const ReviewTile({
    super.key,
    required this.userData,
    required this.review,
    required this.getTimeAgoSinceDate,
  });

  final IMyUser userData;
  final IReview review;
  final Function getTimeAgoSinceDate;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ListTile(
          leading: SizedBox(
            height: 50,
            width: 50,
            child: CachedImageWidget(
                imageUrl: userData.userProfileImage,
                height: 50,
                shape: BoxShape.circle,
                width: 50),
          ),
          title: Text(
            userData.userName,
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
          subtitle: Row(
            children: [
              StarRating(
                size: 20.0,
                rating: review.rating.toDouble(),
                color: Colors.orange,
                borderColor: Colors.grey,
                allowHalfRating: true,
                starCount: 5,
              ),
              const SizedBox(
                width: 5,
              ),
              Text(
                review.rating.toStringAsFixed(1),
                maxLines: 50,
                overflow: TextOverflow.ellipsis,
              ),
            ],
          ),
          trailing: Text(
            getTimeAgoSinceDate(review.creationTime),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Text(review.reviewText),
        ),
        const SizedBox(
          height: 5,
        )
      ],
    );
  }
}
