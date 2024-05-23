import 'ireview.dart';

abstract interface class IReviewRepository {
  Future<void> createReview(IReview review);
  Future<void> deleteReview(String id);
  Stream<List<IReview>> fetchReviewsStreamByUserId(String userId);
  Stream<List<IReview>> fetchReviewsStreamByMovieId(String movieId);
}
