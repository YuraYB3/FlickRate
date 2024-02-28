import 'package:flickrate/domain/movies/imovie.dart';

class Movie implements IMovie {
  @override
  String id;
  @override
  final String name;
  @override
  final String genre;
  @override
  final double rating;
  @override
  final String description;

  Movie(
      {this.id = '',
      this.rating = 5.0,
      required this.name,
      required this.genre,
      required this.description});

  factory Movie.fromJson(Map<String, dynamic> json) {
    return Movie(
      id: json['id'],
      name: json['name'],
      genre: json['genre'],
      rating: json['rating'],
      description: json['description'],
    );
  }

  @override
  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'genre': genre,
      'description': description,
      'rating': rating
    };
  }
}
