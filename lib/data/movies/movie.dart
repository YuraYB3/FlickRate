import 'package:flickrate/domain/movies/imovie.dart';

class Movie implements IMovie {
  @override
  String id = '';
  @override
  final String name;
  @override
  final String genre;
  @override
  final String description;

  Movie(
      {required this.id,
      required this.name,
      required this.genre,
      required this.description});

  factory Movie.fromJson(Map<String, dynamic> json) {
    return Movie(
      id: json['id'] ?? '',
      name: json['name'],
      genre: json['genre'],
      description: json['description'],
    );
  }

  @override
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'genre': genre,
      'description': description,
    };
  }
}
