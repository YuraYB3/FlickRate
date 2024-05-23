import '../ibase_model.dart';

abstract interface class IMovie implements IBaseModel {
  final String movieName;
  final String movieGenre;
  final num movieRating;
  final String movieDescription;
  final String movieImg;
  final num numberOfReviews;

  IMovie(this.numberOfReviews,
      {required this.movieRating,
      required this.movieName,
      required this.movieGenre,
      required this.movieDescription,
      required this.movieImg});
}
