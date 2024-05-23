import 'package:flutter/material.dart';
import 'package:flutter_rating/flutter_rating.dart';

class UserReviewTile extends StatefulWidget {
  final String movieName;
  final num rating;
  final String reviewText;
  final Function getTimeAgoSinceDate;
  final DateTime creationTime;

  const UserReviewTile(
      {super.key,
      required this.movieName,
      required this.rating,
      required this.reviewText,
      required this.getTimeAgoSinceDate,
      required this.creationTime});

  @override
  State<UserReviewTile> createState() => _UserReviewTileState();
}

class _UserReviewTileState extends State<UserReviewTile> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ListTile(
          title: Text(
            widget.movieName,
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
          subtitle: Row(
            children: [
              StarRating(
                size: 20.0,
                rating: widget.rating.toDouble(),
                color: Colors.orange,
                borderColor: Colors.grey,
                allowHalfRating: true,
                starCount: 5,
              ),
              const SizedBox(
                width: 5,
              ),
              Text(
                widget.rating.toStringAsFixed(1),
                overflow: TextOverflow.ellipsis,
              ),
            ],
          ),
          trailing: Text(
            widget.getTimeAgoSinceDate(widget.creationTime),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Text(
            widget.reviewText,
            maxLines: 3,
            overflow: TextOverflow.ellipsis,
          ),
        ),
        const SizedBox(
          height: 5,
        )
      ],
    );
  }
}
