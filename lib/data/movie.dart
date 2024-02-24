import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flickrate/domain/ibase_model.dart';

class MovieModel implements IBaseModel {
  final String name;
  final String genre;
  final String description;

  MovieModel(
      {required this.name, required this.genre, required this.description});

  factory MovieModel.fromJson(Map<String, dynamic> json) {
    return MovieModel(
      name: json['name'],
      genre: json['genre'],
      description: json['description'],
    );
  }

  @override
  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'genre': genre,
      'description': description,
    };
  }
}

class MovieRepository {
  Stream<List<MovieModel>> fetchMoviesStream() =>
      FirebaseFirestore.instance.collection('movies').snapshots().map((event) =>
          event.docs.map((e) => MovieModel.fromJson(e.data())).toList());

  Future<void> addMovie(MovieModel movie) async {
    try {
      await FirebaseFirestore.instance.collection('movies').add(movie.toJson());
    } catch (error) {
      //
    }
  }
}
