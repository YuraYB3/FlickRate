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
  final String movieGenre;
  @override
  final String movieName;
  @override
  final String userName;
  @override
  final String userImage;

  @override
  String documentId;

  Review({
    this.documentId = '',
    this.movieName = '',
    this.movieGenre = '',
    this.userImage = '',
    this.userName = '',
    required this.movieId,
    required this.reviewText,
    required this.userId,
    required this.rating,
  });

  factory Review.fromJson(Map<String, dynamic> json) {
    return Review(
        movieName: json['movieName'],
        rating: json['rating'],
        movieId: json['movieId'],
        reviewText: json['reviewText'],
        userId: json['userId'],
        documentId: json['documentId'],
        movieGenre: json['movieGenre'],
        userImage: json['userImage'],
        userName: json['userName']);
  }
  @override
  Map<String, dynamic> toJson() {
    return {
      'rating': rating,
      'movieId': movieId,
      'reviewText': reviewText,
      'userId': userId,
    };
  }
}
