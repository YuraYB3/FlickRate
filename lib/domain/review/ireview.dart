import '../ibase_model.dart';

abstract interface class IReview implements IBaseModel {
  final String movieId;
  final String userId;
  final String reviewText;
  final String movieGenre;
  final String movieName;
  final num rating;

  IReview({
    required this.movieName,
    required this.rating,
    required this.reviewText,
    required this.movieId,
    required this.userId,
    required this.movieGenre,
  });
}
