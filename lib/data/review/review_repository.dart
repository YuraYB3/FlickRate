import 'package:flickrate/data/review/review.dart';
import 'package:flickrate/domain/network/inetwork_service.dart';
import 'package:flickrate/domain/review/ireview_repository.dart';

import '../../app/services/network/collection_name.dart';
import '../../domain/review/ireview.dart';

class ReviewRepository implements IReviewRepository {
  final INetworkService _networkService;
  ReviewRepository({required INetworkService networkService})
      : _networkService = networkService;

  @override
  Future<void> createReview(IReview review) async {
    _networkService.create(review.toJson(), collectionReviews);
  }

  @override
  Future<void> deleteReview(String id) async {
    await _networkService.delete(id, collectionReviews);
  }

  @override
  Stream<IReview> fetchReview(String id) {
    return _networkService
        .read(id, collectionReviews)
        .map((event) => Review.fromJson(event));
  }

  @override
  Stream<List<IReview>> fetchReviewsStream() {
    return _networkService.fetchDataStream(collectionReviews).map(
          (dataList) => dataList.map((data) => Review.fromJson(data)).toList(),
        );
  }

  @override
  Stream<List<IReview>> fetchReviewsStreamByUserId(String userId) {
    return fetchReviewsStream().map(
        (movies) => movies.where((review) => review.userId == userId).toList());
  }

  @override
  Future<void> updateReview(IReview review) async {}

  @override
  Stream<List<IReview>> fetchReviewsStreamByMovieId(String movieId) {
    return fetchReviewsStream().map((movies) =>
        movies.where((review) => review.movieId == movieId).toList());
  }
}
