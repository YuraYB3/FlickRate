import '../../app/services/functions/endpoints.dart';
import '../../app/services/functions/ifunction_service.dart';
import '../../app/services/network/collection_name.dart';
import '../../app/services/network/inetwork_service.dart';
import '../../domain/movies/imovie.dart';
import '../../domain/movies/imovie_repository.dart';
import 'movie.dart';

class MovieRepository implements IMovieRepository {
  final INetworkService _networkService;
  final IFunctionService _functionService;

  MovieRepository({
    required INetworkService networkService,
    required IFunctionService functionService,
  })  : _networkService = networkService,
        _functionService = functionService;

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
  Future<void> deleteMovie(String id) async {
    await _networkService.delete(id, collectionMovies);
  }

  @override
  Stream<IMovie> fetchMovie(String id) {
    return _networkService
        .read(id, collectionMovies)
        .map((event) => Movie.fromJson(event));
  }

  @override
  Future<void> updateMovie(IMovie movie) {
    // implement updateMovie
    throw UnimplementedError();
  }

  @override
  Stream<List<IMovie>> fetchMoviesStreamByGenre(String genre) {
    return _networkService.fetchDataStream(collectionMovies).map((dataList) =>
        dataList
            .where((data) => data['genre'] == genre)
            .map((data) => Movie.fromJson(data))
            .toList());
  }

  @override
  void decreaseRating(String id) {
    _functionService.onCall({"movieId": id}, callableDecreaseRating);
  }

  @override
  void increaseRating(String id) {
    _functionService.onCall({"movieId": id}, callableIncreaseRating);
  }
}
