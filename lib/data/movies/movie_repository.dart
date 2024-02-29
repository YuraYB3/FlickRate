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
  Future<void> createMovie(IMovie movie) async {
    _networkService.create(movie.toJson(), collectionMovies);
  }

  @override
  Future<void> deleteMovie(IMovie movie) async {
    await _networkService.delete(movie, collectionMovies);
  }

  @override
  Stream<IMovie> fetchMovie(String id) {
    return _networkService
        .read(id, collectionMovies)
        .map((event) => Movie.fromJson(event));
  }

  @override
  Future<void> updateMovie(IMovie movie) {
    // TODO: implement updateMovie
    throw UnimplementedError();
  }
}
