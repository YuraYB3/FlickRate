import 'ireview.dart';

abstract interface class IReviewRepository {
  Future<void> createReview(IReview review);
  Future<void> updateReview(IReview review);
  Future<void> deleteReview(String id);
  Stream<List<IReview>> fetchReviewsStream();
  Stream<IReview> fetchReview(String id);
  Stream<List<IReview>> fetchReviewsStreamByUserId(String userId);
}
