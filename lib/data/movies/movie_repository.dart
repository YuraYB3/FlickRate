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
  Stream<List<IMovie>> fetchMoviesStream() {
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
  Stream<List<IMovie>> fetchMoviesStreamByGenre(String genre) {
    return fetchMoviesStream().map((movies) =>
        movies.where((movie) => movie.movieGenre == genre).toList());
  }

  @override
  Stream<List<IMovie>> fetchMoviesByName(String movieName) {
    return fetchMoviesStream().map((movies) => movies
        .where(
          (movie) => movie.movieName.toLowerCase().contains(
                movieName.toLowerCase(),
              ),
        )
        .toList());
  }
}
