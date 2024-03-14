import '../../domain/movies/imovie.dart';

class Movie implements IMovie {
  @override
  String documentId;
  @override
  String userId;
  @override
  final String name;
  @override
  final String genre;
  @override
  final num rating;
  @override
  final String description;

  Movie(
      {this.documentId = '',
      required this.userId,
      this.rating = 4,
      required this.name,
      required this.genre,
      required this.description});

  factory Movie.fromJson(Map<String, dynamic> json) {
    return Movie(
        documentId: json['documentId'],
        name: json['name'],
        genre: json['genre'],
        rating: json['rating'],
        description: json['description'],
        userId: json['userId']);
  }

  @override
  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'genre': genre,
      'description': description,
      'rating': rating,
      'userId': userId
    };
  }
}
