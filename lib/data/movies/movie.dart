import '../../domain/movies/imovie.dart';

class Movie implements IMovie {
  @override
  String documentId;
  @override
  final String movieName;
  @override
  final String movieImg;
  @override
  final String movieGenre;
  @override
  final num movieRating;
  @override
  final String movieDescription;
  @override
  final num numberOfReviews;

  Movie(
      {required this.movieName,
      required this.numberOfReviews,
      required this.documentId,
      required this.movieImg,
      required this.movieRating,
      required this.movieGenre,
      required this.movieDescription});

  factory Movie.fromJson(Map<String, dynamic> json) {
    return Movie(
        documentId: json['documentId'],
        movieName: json['movieName'],
        movieGenre: json['movieGenre'],
        movieRating: json['movieRating'],
        movieDescription: json['movieDescription'],
        movieImg: json['movieImg'],
        numberOfReviews: json['numberOfReviews']);
  }

  @override
  Map<String, dynamic> toJson() {
    return {
      'movieName': movieName,
      'movieGenre': movieGenre,
      'movieDescription': movieDescription,
      'movieRating': movieRating,
      'movieImg': movieImg,
      'documentId': documentId,
      'numberOfReviews': numberOfReviews
    };
  }
}
