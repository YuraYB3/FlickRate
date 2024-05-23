import '../../app/services/network/collection_name.dart';
import '../../domain/network/inetwork_service.dart';
import '../../domain/movies/imovie.dart';
import '../../domain/movies/imovie_repository.dart';
import 'movie.dart';

enum MovieSortType { byMovieNameAscending, byMovieNameDescending }

class MovieRepository implements IMovieRepository {
  final INetworkService _networkService;
  MovieRepository({
    required INetworkService networkService,
  }) : _networkService = networkService;

  Stream<List<IMovie>> _fetchMoviesStream() {
    return _networkService.fetchDataStream(collectionMovies).map(
          (dataList) => dataList.map((data) => Movie.fromJson(data)).toList(),
        );
  }

  @override
  Stream<List<IMovie>> fetchMoviesByName(String movieName) {
    return _fetchMoviesStream().map((movies) => movies
        .where(
          (movie) => movie.movieName.toLowerCase().contains(
                movieName.toLowerCase(),
              ),
        )
        .toList());
  }

  @override
  Future<IMovie> getMovieById(String id) async {
    Stream<List<IMovie>> moviesStream = _fetchMoviesStream();
    List<IMovie> moviesList = await moviesStream.first;
    IMovie movie = moviesList.firstWhere((movie) => movie.documentId == id);
    return movie;
  }

  @override
  Stream<IMovie> getDailyMovie() {
    Stream<Movie> moviesStream = _networkService
        .fetchDataStream(collectionDaily)
        .map((dataList) => dataList
            .map(
              (data) => Movie.fromJson(data),
            )
            .first);
    return moviesStream;
  }

  @override
  Stream<List<IMovie>> fetchAllMoviesStream(
      {MovieSortType sortType = MovieSortType.byMovieNameAscending}) {
    return _fetchMoviesStream().map(
      (movies) {
        var sortedMovies = movies.toList();
        switch (sortType) {
          case MovieSortType.byMovieNameAscending:
            sortedMovies.sort((a, b) => a.movieName.compareTo(b.movieName));
            break;
          case MovieSortType.byMovieNameDescending:
            sortedMovies.sort((a, b) => b.movieName.compareTo(a.movieName));
            break;
        }
        return sortedMovies;
      },
    );
  }
}
