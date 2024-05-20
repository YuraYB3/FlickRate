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
  Stream<List<IMovie>> fetchMoviesStream(
      {String collectionName = collectionMovies}) {
    return _networkService.fetchDataStream(collectionName).map(
          (dataList) => dataList.map((data) => Movie.fromJson(data)).toList(),
        );
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

  @override
  Future<IMovie> getMovieById(String id) async {
    Stream<List<IMovie>> moviesStream = fetchMoviesStream();
    List<IMovie> moviesList = await moviesStream.first;
    IMovie movie = moviesList.firstWhere((movie) => movie.documentId == id);
    return movie;
  }

  @override
  Future<IMovie> getDailyMovie() async {
    Stream<List<IMovie>> moviesStream =
        fetchMoviesStream(collectionName: collectionDaily);
    List<IMovie> moviesList = await moviesStream.first;
    if (moviesList.isEmpty) {
      throw Exception('No movies available');
    }
    IMovie randomMovie = moviesList[0];
    return randomMovie;
  }
}
