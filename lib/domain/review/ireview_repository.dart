import 'ireview.dart';

enum ReviewSortType {
  byDateDescending,
  byDateAscending,
  byMovieNameAscending,
  byMovieNameDescending
}

abstract interface class IReviewRepository {
  Future<void> createReview(IReview review);
  Future<void> deleteReview(String id);
  Stream<List<IReview>> fetchReviewsStreamByUserId(String userId,
      {ReviewSortType sortType = ReviewSortType.byDateDescending});
  Stream<List<IReview>> fetchReviewsStreamByMovieId(String movieId,
      {ReviewSortType sortType = ReviewSortType.byDateDescending});
  Stream<List<IReview>> fetchReviewsStreamByUserIdAndGenre(
      String genre, String userId,
      {ReviewSortType sortType = ReviewSortType.byDateDescending});
}
