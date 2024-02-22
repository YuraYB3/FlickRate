import 'package:cloud_firestore/cloud_firestore.dart';

class Movie {
  final String name;
  final String genre;
  final String description;

  Movie({required this.name, required this.genre, required this.description});

  factory Movie.fromJson(Map<String, dynamic> json) {
    return Movie(
      name: json['name'],
      genre: json['genre'],
      description: json['description'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'genre': genre,
      'description': description,
    };
  }
}

class MovieModel {
  Stream<List<Movie>> getMovies() => FirebaseFirestore.instance
      .collection('movies')
      .snapshots()
      .map((event) => event.docs.map((e) => Movie.fromJson(e.data())).toList());

  Future<void> addMovie(Movie movie) async {
    try {
      await FirebaseFirestore.instance.collection('movies').add(movie.toJson());
    } catch (error) {
      //
    }
  }
}
