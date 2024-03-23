import '../../app/services/network/collection_name.dart';
import '../../domain/network/inetwork_service.dart';
import '../../domain/movies/imovie.dart';
import '../../domain/movies/imovie_repository.dart';
import 'movie.dart';

class MovieRepository implements IMovieRepository {
  final INetworkService _networkService;

  MovieRepository({
    required INetworkService networkService,
  }) : _networkService = networkService;

  @override
  Stream<List<IMovie>> fetchMoviesStream(String userId) {
    return _networkService.fetchDataStream(collectionMovies).map(
          (dataList) => dataList.map((data) => Movie.fromJson(data)).toList(),
        );
  }

  @override
  Stream<IMovie> fetchMovie(String id) {
    return _networkService
        .read(id, collectionMovies)
        .map((event) => Movie.fromJson(event));
  }

  @override
  Stream<List<IMovie>> fetchMoviesStreamByGenre(String genre, String userId) {
    return fetchMoviesStream(userId).map((movies) =>
        movies.where((movie) => movie.movieGenre == genre).toList());
  }
}
