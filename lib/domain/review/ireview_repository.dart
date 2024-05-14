import 'ireview.dart';

abstract interface class IReviewRepository {
  Future<void> createReview(IReview review);
  Future<void> updateReview(IReview review);
  Future<void> deleteReview(String id);
  Stream<List<IReview>> fetchReviewsStream();
  Stream<IReview> fetchReview(String id);
  Stream<List<IReview>> fetchReviewsStreamByUserId(String userId);
  Stream<List<IReview>> fetchReviewsStreamByUserIdAndMovieGenre(
      String movieGenre, String userId);
  Stream<List<IReview>> fetchReviewsStreamByMovieId(String movieId);
}
