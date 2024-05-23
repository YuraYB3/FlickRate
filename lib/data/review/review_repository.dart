import 'package:flickrate/data/review/review.dart';
import 'package:flickrate/domain/network/inetwork_service.dart';
import 'package:flickrate/domain/review/ireview_repository.dart';

import '../../app/services/network/collection_name.dart';
import '../../domain/review/ireview.dart';

enum ReviewSortType {
  byDateDescending,
  byDateAscending,
  byMovieNameAscending,
  byMovieNameDescending
}

class ReviewRepository implements IReviewRepository {
  final INetworkService _networkService;
  ReviewRepository({required INetworkService networkService})
      : _networkService = networkService;

  @override
  Future<void> createReview(IReview review) async {
    await _networkService.create(review.toJson(), collectionReviews);
  }

  @override
  Future<void> deleteReview(String id) async {
    await _networkService.delete(id, collectionReviews);
  }

  Stream<List<IReview>> _fetchReviewsStream() {
    return _networkService.fetchDataStream(collectionReviews).map(
          (dataList) => dataList.map((data) => Review.fromJson(data)).toList(),
        );
  }

  @override
  Stream<List<IReview>> fetchReviewsStreamByUserId(String userId,
      {ReviewSortType sortType = ReviewSortType.byDateDescending}) {
    return _fetchReviewsStream().map((reviews) {
      List<IReview> filteredReviews =
          reviews.where((review) => review.userId == userId).toList();
      switch (sortType) {
        case ReviewSortType.byDateDescending:
          filteredReviews.sort(
            (a, b) => b.creationTime.compareTo(a.creationTime),
          );
          break;
        case ReviewSortType.byDateAscending:
          filteredReviews.sort(
            (a, b) => a.creationTime.compareTo(b.creationTime),
          );
          break;
        case ReviewSortType.byMovieNameAscending:
          filteredReviews.sort(
            (a, b) => a.movieName.compareTo(b.movieName),
          );
          break;
        case ReviewSortType.byMovieNameDescending:
          filteredReviews.sort(
            (a, b) => b.movieName.compareTo(a.movieName),
          );
          break;
      }

      return filteredReviews;
    });
  }

  @override
  Stream<List<IReview>> fetchReviewsStreamByMovieId(String movieId,
      {ReviewSortType sortType = ReviewSortType.byDateDescending}) {
    return _fetchReviewsStream().map((reviews) {
      List<IReview> filteredReviews =
          reviews.where((review) => review.movieId == movieId).toList();
      switch (sortType) {
        case ReviewSortType.byDateDescending:
          filteredReviews.sort(
            (a, b) => b.creationTime.compareTo(a.creationTime),
          );
          break;
        case ReviewSortType.byDateAscending:
          filteredReviews.sort(
            (a, b) => a.creationTime.compareTo(b.creationTime),
          );
          break;
        case ReviewSortType.byMovieNameAscending:
          filteredReviews.sort(
            (a, b) => a.movieName.compareTo(b.movieName),
          );
          break;
        case ReviewSortType.byMovieNameDescending:
          filteredReviews.sort(
            (a, b) => b.movieName.compareTo(a.movieName),
          );
          break;
      }
      return filteredReviews;
    });
  }
}
