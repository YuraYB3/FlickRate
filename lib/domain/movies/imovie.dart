import '../ibase_model.dart';

abstract interface class IMovie implements IBaseModel {
  final String movieName;
  final String movieGenre;
  final String movieRating;
  final String movieDescription;
  final String movieImg;

  IMovie(
      {required this.movieRating,
      required this.movieName,
      required this.movieGenre,
      required this.movieDescription,
      required this.movieImg});
}
