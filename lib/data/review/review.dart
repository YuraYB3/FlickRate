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
  final DateTime creationTime;

  @override
  String documentId;

  Review(
      {this.documentId = '',
      required this.movieGenre,
      required this.movieName,
      required this.movieId,
      required this.reviewText,
      required this.userId,
      required this.rating,
      required this.creationTime});

  factory Review.fromJson(Map<String, dynamic> json) {
    return Review(
      userId: json['userId'],
      documentId: json['documentId'],
      movieId: json['movieId'],
      movieName: json['movieName'],
      movieGenre: json['movieGenre'],
      rating: json['rating'],
      reviewText: json['reviewText'],
      creationTime: DateTime.parse(json['creationTime']),
    );
  }
  @override
  Map<String, dynamic> toJson() {
    return {
      'rating': rating,
      'movieId': movieId,
      'reviewText': reviewText,
      'userId': userId,
      'movieName': movieName,
      'movieGenre': movieGenre,
      'creationTime':creationTime.toIso8601String()
    };
  }
}
