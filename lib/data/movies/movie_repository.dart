import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flickrate/app/services/network/collection_name.dart';
import 'package:flickrate/app/services/network/inetwork_service.dart';

import '../../domain/movies/imovie.dart';
import '../../domain/movies/imovie_repository.dart';
import 'movie.dart';

class MovieRepository implements IMovieRepository {
  final INetworkService _networkService;

  MovieRepository({required INetworkService networkService})
      : _networkService = networkService;

  @override
  Stream<List<IMovie>> fetchMoviesStream() {
    return _networkService.fetchDataStream(collectionMovies).map(
        (dataList) => dataList.map((data) => Movie.fromJson(data)).toList());
  }

  @override
  Future<IMovie?> fetchMovie(IMovie movie) async {
    try {
      DocumentSnapshot<Map<String, dynamic>> movieDoc =
          await _networkService.read(movie, collectionMovies);

      return Movie.fromJson(movieDoc.data()!);
    } catch (error) {
      return null;
    }
  }

  @override
  Future<void> createMovie(IMovie movie) async {
    _networkService.create(movie.toJson(), collectionMovies);
  }

  @override
  Future<void> updateMovie(IMovie movie) async {
    _networkService.update(movie, collectionMovies);
  }

  @override
  Future<void> deleteMovie(IMovie movie) async {
    await _networkService.delete(movie, collectionMovies);
  }
}
