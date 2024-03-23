import '../../domain/review/ireview.dart';

class Review implements IReview {
  @override
  final String movieId;
  @override
  final String userId;
  @override
  final String reviewText;
  @override
  final num rating;

  @override
  String documentId;

  Review(
      {required this.documentId,
      required this.movieId,
      required this.reviewText,
      required this.userId,
      required this.rating});

  factory Review.fromJson(Map<String, dynamic> json) {
    return Review(
      rating: json['rating'],
      movieId: json['movieId'],
      reviewText: json['reviewText'],
      userId: json['userId'],
      documentId: json['documentId'],
    );
  }
  @override
  Map<String, dynamic> toJson() {
    return {
      'rating': rating,
      'movieId': movieId,
      'reviewText': reviewText,
      'userId': userId,
      'documentId': documentId
    };
  }
}
